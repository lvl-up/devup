execute :install_rvm do
  user node[:user][:name]
  group node[:user][:name]
  cwd "/home/#{node[:user][:name]}"
  command "sudo #{node[:user][:name]} curl -L https://get.rvm.io | bash -s stable --ruby"
  action :run
end