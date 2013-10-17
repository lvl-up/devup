module UserHelpers
  def generate_user_password password
    user_password = Mixlib::ShellOut.new(%Q{openssl passwd -1 "#{password}"})
    user_password.run_command
    user_password.stdout.chomp
  end
end

class Chef::Resource::User
  include UserHelpers
end