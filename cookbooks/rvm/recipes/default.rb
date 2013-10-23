bash :install_rvm do
  user = node[:rvm][:user]
  ruby_versions = node[:rvm][:versions]
  code <<BASH
     wget -O /tmp/rvm.sh https://get.rvm.io; echo
     sudo -u #{user} -s /bin/bash /tmp/rvm.sh

     sudo -u #{user} -s /bin/bash -l -c 'source /home/#{user}/.bash_profile;'
     sudo -u #{user} -s /bin/bash -l -c '#{ruby_versions.collect { |version| "rvm install #{version}" }.join('; ') }'

BASH
  action :run
end