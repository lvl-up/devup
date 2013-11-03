# -*- mode: ruby -*-
# vi: set ft=ruby :

PROVIDER = 'vmware-fusion'
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu13.04"
  config.berkshelf.enabled = true

  config.vm.provider PROVIDER do |provider|
    provider.gui = true
    provider.name = 'dev'
    provider.vmx["memsize"] = "4092"
    provider.vmx["numvcpus"] = "2"
  end

  config.vm.provision :shell, :inline => "apt-get update"
  config.vm.provision :shell, :inline => "apt-get install -y curl"
  config.vm.provision :shell, :inline => "apt-get install -y unzip"


  config.vm.synced_folder "/Applications/VMware Fusion.app/Contents/Library/isoimages", "/tmp/vmware_tools_isos"  if PROVIDER=="vmware_fusion"
  config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | bash"


  user = 'team'
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "user"
    #chef.add_recipe "rvm"
    #chef.add_recipe "vmware_tools" if PROVIDER=="vmware_fusion"
    #chef.log_level = "debug"
    #chef.add_recipe "java::oracle"
    #chef.add_recipe "intellij"
    #chef.add_recipe "intellij::plugins"
    #chef.add_recipe "ubuntu"
    #chef.add_recipe "gnome"
    #chef.add_recipe "chromium-webdriver"

    chef.json = {
        :user => {
            :name => user,
            :password => 'password',
            :shell => '/bin/bash'
        },
        :java => {
            :oracle => {
                :accept_oracle_download_terms => true
            },
            :jdk_version => 7
        },
        :vmware_tools => {
            :source => '/tmp/vmware_tools_isos/linux.iso'
        },
        :rvm => {
            :user => user,
            :default_gems => %w{rake rspec bundler hub},
            :rubies => [
                {:version => '1.9.3', :gems => %w{}},
                {:version => '2.0.0', :gems => %w{ruby-debug-ide}}
            ]
        },
        :intellij => {
            :user => user,
            :version => '12.1.6',
            :plugins => {
                :ruby => { :url => '/1293/13661/ruby-5.4.0.20130703.zip' },
                :bash_support => { :url => '/4230/13925/BashSupport.jar' }
            }
        },
        :chromium_webdriver => {
            :version => '2.3',
            :path => '/usr/local/bin'
        }

    }
  end

  config.vm.provision :shell, :inline => "shutdown -r now"
end
