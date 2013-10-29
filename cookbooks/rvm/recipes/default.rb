bash :install_rvm do
  user = node[:rvm][:user]
  rubies = node[:rvm][:rubies]
  default_gems = node[:rvm][:default_gems]

  install_ruby = <<BASH
    wget -O /tmp/rvm.sh https://get.rvm.io; echo
    sudo -H -u #{user} bash -c '/bin/bash /tmp/rvm.sh'
    sudo -H -u #{user} bash -c '/bin/bash -l -c "source /home/#{user}/.bash_profile;"'
     #{rubies.collect { |ruby| "sudo -H -u #{user} bash -c '/bin/bash -l -c \"rvm install #{ruby[:version]}\"" }.join("\n") }

BASH

  gem_install_commands = rubies.collect {|ruby| "rvm #{ruby[:version]}@global do gem install #{default_gems.concat(ruby[:gems]).join(' ')}" }

  command = install_ruby.concat(gem_install_commands.collect { |gem_install_command| "sudo -H -u #{user} bash -c '/bin/bash -l -c \"#{gem_install_command}\"" }.join("\n"))

  code(command)

  action :run
end