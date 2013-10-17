user node[:user][:name] do
  action :create
  shell node[:user][:shell] || '/bin/bash'
  password generate_user_password(node[:user][:password])
  home "/home/#{node[:user][:name]}"
  supports :manage_home => true
end
