require 'spec_helper'


describe 'gnome::disable_shortcuts' do


  let(:shortcut){'<Control><Alt>Delete'}

  let(:user){'user'}
  let(:chef_run) do
    ChefSpec::Runner.new(step_into: [:ruby_block]) do|node|
      node.set[:gnome][:user] = user
      node.set[:gnome][:disable_shortcuts] = %W(#{shortcut})
    end.converge(described_recipe)
  end

  let(:gnome_schemas){["org.gnome.desktop.wm.keybindings", "org.gnome.settings-daemon.plugins.media-keys"]}


  #TODO test library

  describe 'clearing a shortcut' do
    it 'it should get the key for the shortcut and clear it' do
      #TODO - test usage of gsettings module
      GSettings.should_receive(:key).with('user', gnome_schemas, shortcut)
      chef_run
    end

    it 'should clear the shortcut from gsettings when the key is found' do
      GSettings.stub(:key).and_return(:key)
      GSettings.should_receive(:clear).with(user, gnome_schemas, :key)
      chef_run
    end

    it 'should not attempt to clear the shortcut if the key is not found' do
      GSettings.stub(:key).and_return(nil)
      GSettings.should_not_receive(:clear)
      chef_run
    end
  end

end
