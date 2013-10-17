# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu13.04"

  config.vm.provider 'vmware_fusion' do |provider|
    provider.gui = true
    provider.vmx["memsize"] = "2048"
    provider.vmx["numvcpus"] = "2"
  end

  config.vm.provision :shell, :inline => "apt-get update"
  config.vm.provision :shell, :inline => "apt-get install -y curl"

  config.vm.synced_folder "/Applications/VMware Fusion.app/Contents/Library/isoimages", "/tmp/vmware_tools_isos"
  config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | bash"


  user = 'team'
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "user"
    chef.add_recipe "rvm"
    chef.add_recipe "vmware_tools"
    chef.log_level = "debug"
    chef.add_recipe "java::oracle"
    chef.add_recipe "intellij"
    chef.add_recipe "ubuntu"
    chef.add_recipe "gnome"

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
            :user => user
        },
        :intellij => {
            :user => user,
            :version => '12.1.6'
        }

    }
  end

  config.vm.provision :shell, :inline => "shutdown -r now"
end
