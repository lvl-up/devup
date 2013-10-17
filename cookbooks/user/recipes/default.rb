user node[:user][:name] do
  action :create
  shell node[:user][:shell] || '/bin/bash'
  password generate_user_password(node[:user][:password])
  home "/home/#{node[:user][:name]}"
  supports :manage_home => true
end

bash :add_user_sudo do
  user 'root'
  code <<-BASH
  sed -i -e "s/Defaults\s*requiretty/#Defaults requiretty/g" /etc/sudoers
  echo '#{node[:user][:name]} ALL=(ALL)ALL' >> /etc/sudoers
  echo '#{node[:user][:name]} ALL=NOPASSWD:ALL' >> /etc/sudoers
  BASH
end