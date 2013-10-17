bash :install_rvm do
  user = node[:rvm][:user]
  code <<BASH
     wget -O /tmp/rvm.sh https://get.rvm.io; echo
     sudo -u #{user} -s /bin/bash /tmp/rvm.sh

     sudo -u #{user} -s /bin/bash -l -c 'source /home/#{user}/.bash_profile; rvm install 1.9.3'

BASH
  action :run
end