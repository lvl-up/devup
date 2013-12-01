package 'vim'
package 'unzip'
package 'git-core'
package 'git-doc'
package 'apache2'
package 'libmagickwand-dev'

# Nokogiri compilation dependencies
package 'libxml2-dev'
package 'libxslt-dev'

# Needed for grunt-webfont
package 'fontforge'
package 'ttfautohint'

bash :configure_system_timezone do
  user 'root'
  code <<-BASH
    echo "#{node[:ubuntu][:timezone]}" | tee /etc/timezone
    dpkg-reconfigure --frontend noninteractive tzdata
    locale-gen
  BASH
end
