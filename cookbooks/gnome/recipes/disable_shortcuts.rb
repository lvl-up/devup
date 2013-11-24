user = node[:gnome][:user]
node[:gnome][:disable_shortcuts].each do |shortcut|
  ruby_block "remove_shortcut #{shortcut}" do
    block do
      schemas = ['org.gnome.desktop.wm.keybindings',
                 'org.gnome.settings-daemon.plugins.media-keys']
      key = GSettings.key(user, schemas, shortcut)
      puts "found key: #{key} when searching for: #{shortcut}"
      GSettings.clear(user, schemas, key) if key
    end
  end
end



