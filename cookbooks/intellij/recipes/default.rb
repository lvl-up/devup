ark 'intellij' do
  user = node[:intellij][:user]
  owner user
  url "http://download.jetbrains.com/idea/ideaIU-#{node[:intellij][:version]}.tar.gz"
  action :put
  path "/home/#{user}/Applications"
end

ubuntu_shortcut :intellij do
  user = node[:intellij][:user]
  icon "/home/#{user}/Applications/intellij/bin/idea.png"
  application "/home/#{user}/Applications/intellij/bin/idea.sh"
  username user
end