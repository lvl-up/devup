Bundler.require :test
require 'chefspec'
$LOAD_PATH.unshift("#{__dir__}/../libraries")
require 'gsettings'

RSpec.configure do |config|
  module Kernel
    class << self
      alias_method :load_backup, :load
      def excluded_libraries
        @excluded_libraries ||= []
      end
      def load string, options={}
        load_backup(string, options) unless excluded_libraries.find{|library| string.include?(library.to_s)}
      end
    end
  end

  config.before :suite do
    Dir["#{__dir__}/../libraries/**/*.rb"].each do |library|
      require library
      Kernel.excluded_libraries << library
    end
  end
end