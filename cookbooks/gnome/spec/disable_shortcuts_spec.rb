Bundler.require :test
require 'chefspec'

describe 'gnome::disable_shortcuts' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }


  it 'should create a tasks to clear each shortcut' do

  end

  #TODO test library

  describe 'clearing a shortcut' do
    it 'it should get the key for the shortcut and clear it' do
      #TODO - test usage of gsettings module

    end
  end

end
