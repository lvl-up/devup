user = node[:intellij][:user]

ark 'intellij' do
  owner user
  url "http://download.jetbrains.com/idea/ideaIU-#{node[:intellij][:version]}.tar.gz"
  action :put
  path "/home/#{user}/Applications"
end

ubuntu_shortcut :intellij do
  icon "/home/#{user}/Applications/intellij/bin/idea.png"
  application "/home/#{user}/Applications/intellij/bin/idea.sh"
  username user
end