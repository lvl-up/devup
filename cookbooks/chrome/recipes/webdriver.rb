bash :install_chromium_webdriver do
  code <<BASH
     wget "http://chromedriver.storage.googleapis.com/#{node[:chromium_webdriver][:version]}/chromedriver_linux64.zip"; echo
     unzip chromedriver_linux64.zip
     mv chromedriver #{node[:chromium_webdriver][:path]}
     chmod a+x #{node[:chromium_webdriver][:path]}/chromedriver
BASH
  action :run
end
