def initialize(name, run_context=nil)
  super
  @name = name
  @allowed_actions.push(:install)
  @action = :install
end


actions :install

attr_accessor :icon, :user, :application, :username
attribute :username, :kind_of => String
attribute :icon, :kind_of => String
attribute :application, :kind_of => String

