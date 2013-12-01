remote_file "/tmp/chrome.deb" do
  source "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
end

bash :install_chrome do
  code "dpkg -i /tmp/chrome.deb"
end
