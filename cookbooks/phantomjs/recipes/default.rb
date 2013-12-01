phantomjs_version = 'phantomjs-1.9.2-linux-x86_64'
phantomjs_archive = "/tmp/#{phantomjs_version}.tar.bz2"
remote_file phantomjs_archive do
  source 'https://phantomjs.googlecode.com/files/phantomjs-1.9.2-linux-x86_64.tar.bz2'
end

bash :install_phantomjs do
  code <<-BASH
    tar -C /tmp -xjf #{phantomjs_archive}
    cp /tmp/#{phantomjs_version}/bin/phantomjs /usr/bin
  BASH
end
