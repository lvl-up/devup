ark 'intellij' do
  owner node[:user][:name]
  url 'http://download.jetbrains.com/idea/ideaIU-12.1.4.tar.gz'
  action :put
  path "/home/#{node[:user][:name]}/Applications"
end

ubuntu_shortcut :intellij do
  icon "/home/#{node[:user][:name]}/Applications/intellij/bin/idea.png"
  application "/home/#{node[:user][:name]}/Applications/intellij/bin/idea.sh"
  username node[:user][:name]
end