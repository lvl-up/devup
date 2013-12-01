user = node[:intellij][:user]
base_dir = "/home/#{user}"
plugins_dir = '.IntelliJIdea12/config/plugins'

plugins_dir.split('/').each do |dir|
  directory "#{base_dir}/#{dir}" do
    owner user
    group user
    recursive true
    mode 00755
    action :create
  end

  base_dir << "/#{dir}"
end

file "/tmp/install_plugin" do
  content <<-'CONTENT'
#!/bin/bash

jetbrains_base_url='http://plugins.jetbrains.com'
function find_match(){
    echo $(echo "$1" | perl -p -e "s/$2/\1/")
}

function find_plugin_page(){
  local search_results=$(curl -s "${jetbrains_base_url}/search/index?pr=idea&search=$1" | tr -d '\n')

  local plugin_uri=$(find_match "${search_results}" ".*?dl class=\"category\".*?href=\"(.*?)\"><span.*?>$1<\/span.*" )

  echo "${jetbrains_base_url}${plugin_uri}"
}


function find_plugin_download_url(){
  local plugin_page_url=$1
  local version=$2

  local plugin_page=$(curl -s ${plugin_page_url} | tr -d '\n' | perl -p -e 's/&amp;/&/g' )
  local row_with_version_in_it=$(find_match "${plugin_page}" ".*version_table\".*?(<td>${version}<span>.*?\/tr).*")
  local download_uri=$(find_match "${row_with_version_in_it}" '.*?downld".*?href="(.*?)".*')
  echo "${jetbrains_base_url}${download_uri}"
}
plugin_page_url=$(find_plugin_page "${1}")
plugin_download_url=$(find_plugin_download_url "${plugin_page_url}" "$2")

wget -P ${3} --content-disposition "${plugin_download_url}"
  CONTENT
  mode '755'
  owner user
  group user
  action :create
end


module PluginManager
  class << self
    def plugins path
      require 'yaml'
      plugins_yaml = "#{path}/plugins.yml"
      if File.exists?(plugins_yaml)
        YAML.load(File.read(plugins_yaml))
      else
        {}
      end
    end

    def plugin_installed? path, name, version
      plugins(path)[name] == version
    end
  end
end


node[:intellij][:plugins].each do |plugin, version|
  download_dir = '/tmp/download'
  directory download_dir do
    action :delete
    recursive true
    only_if { File.exists?(download_dir) }
  end

  directory download_dir do
    owner user
    group user
    mode 00777
    action :create
  end

  execute "download_plugin_#{plugin}".to_sym do
    command %Q{/tmp/install_plugin "#{plugin}" "#{version}" '#{download_dir}'}
    user(user)
    group user
    not_if { PluginManager.plugin_installed?(base_dir, plugin, version) }
    notifies :create, "ruby_block[install_plugin_#{plugin}]", :immediately
  end

  ruby_block "install_plugin_#{plugin}".to_sym do
    block do
      download = Dir["#{download_dir}/*.*"].first
      if download.end_with?('.zip')
        `sudo -u #{user} unzip #{download} -d #{base_dir}`
      else
        `sudo -u #{user} cp #{download} -d #{base_dir}/#{File.basename(download)}`
      end
      plugins = PluginManager.plugins(base_dir)
      plugins[plugin] = version
      File.open("#{base_dir}/plugins.yml", 'w') do |file|
        file.write(YAML.dump(plugins))
      end
    end
    action :nothing
  end
end
