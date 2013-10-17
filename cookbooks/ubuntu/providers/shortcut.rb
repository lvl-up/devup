action :install do

  base_dir = "/home/#{new_resource.username}/"
  applications_shortcuts_dir = '.local/share/applications'

  applications_shortcuts_dir.split('/').each do |dir|
    directory "#{base_dir}/#{dir}" do
      owner new_resource.username
      group new_resource.username
      recursive true
      mode 00755
      action :create
    end

    base_dir << "/#{dir}"
  end


  file "#{base_dir}/#{new_resource.name}.desktop" do

    content <<-CONTENT
    #!/usr/bin/env xdg-open

    [Desktop Entry]
    Version=1.0
    Type=Application
    Terminal=false
    Icon[en_US]=#{new_resource.icon}
    Name[en_US]=Intellij
    Exec=#{new_resource.application}
    Name=Intellij
    Icon=#{new_resource.icon}
    CONTENT
    mode '644'
    owner new_resource.username
    group new_resource.username
    action :create
  end
end