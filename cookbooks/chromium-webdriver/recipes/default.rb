bash :install_chromium_webdriver do
  code <<BASH
     wget "http://chromedriver.storage.googleapis.com/2.3/chromedriver_linux64.zip"; echo
     unzip chromedriver_linux64.zip
     mv chromedriver /usr/local/bin
BASH
  action :run
end
