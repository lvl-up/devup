bash :gnome_preflight_steps do
  user 'root'
  code <<-BASH
  echo "debconf debconf/priority select critical" | sudo debconf-set-selections
  echo "gdm shared/default-x-display-manager select gdm" | sudo debconf-set-selections
  echo "lightdm shared/default-x-display-manager select gdm" | sudo debconf-set-selections
  BASH
end

package 'gnome-shell ubuntu-desktop'

bash :gnome_post_install do
  user 'root'
  code <<-BASH
  echo /usr/sbin/gdm | sudo tee /etc/X11/default-display-manager
  echo "debconf debconf/priority select high" | sudo debconf-set-selections
  sudo -u #{node[:user][:name]} gconftool-2 -t boolean --set /apps/gnome-terminal/profiles/Default/login_shell true
  BASH
end

file "/var/lib/AccountsService/users/#{node[:user][:name]}" do
  content <<-CONTENT
  [User]
  XSession=gnome
  XKeyboardLayouts=gb;
  CONTENT
  mode '644'
  owner 'root'
  group 'root'
  action :create
end