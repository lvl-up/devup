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

ark 'ruby' do
  owner user
  url "http://plugins.jetbrains.com/files#{node[:intellij][:plugins][:ruby][:url]}"
  action :put
  path "/home/#{user}/#{plugins_dir}"
end

bash :bash_support do
  user user
  group user
  code <<BASH
    wget -P "/home/#{user}/#{plugins_dir}" http://plugins.jetbrains.com/files#{node[:intellij][:plugins][:bash_support][:url]}
BASH
  action :run
end