require 'spec_helper'

describe GSettings do
  let(:schemas){[:schema]}

  before :each do
    GSettings.instance_variable_set(:@schemas,nil)
  end

  describe 'load_schema' do
    it 'should load the keys in the given schema' do
      GSettings.should_receive(:`).with(%Q{sudo -u user -i gsettings list-keys schema}).and_return("key1\nkey2")
      GSettings.load_schema(:user, :schema).should == %w(key1 key2)
    end

    it 'should cache the schema' do
      GSettings.should_receive(:`).once.and_return("key1\nkey2")
      GSettings.load_schema(:user, :schema)
      GSettings.load_schema(:user, :schema)
    end
  end

  describe 'value' do
    it 'should get the value of a given key' do
      GSettings.should_receive(:`).with(%Q{sudo -u user -i gsettings get schema key}).and_return("value\n")
      GSettings.value(:user, :schema, :key).should == "value"
    end
  end

  describe 'key' do

    it 'should find the key' do
      GSettings.should_receive(:value).with(:user, :schema, :key).and_return("'value'")
      GSettings.stub(:load_schema).and_return([:key])
      GSettings.key(:user, schemas, 'value').should == :key
    end

  end

  describe 'clear' do
    it 'should clear the given key' do
      GSettings.stub(:load_schema)
      GSettings.stub(:schemas).and_return(schema1: [], schema2: [:key])
      GSettings.should_receive(:`).with(%Q{sudo -u user -i dbus-launch gsettings set schema2 key "[]"})
      GSettings.clear(:user, [:schema1, :schema2], :key)
    end
  end

end