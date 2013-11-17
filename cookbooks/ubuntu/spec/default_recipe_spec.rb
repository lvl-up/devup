Bundler.require :test
require 'chefspec'

describe 'ubuntu::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  #TODO these should be moved in to the recipes that need them
  it 'should install required core packages' do
    expect(chef_run).to install_package('unzip')
  end
  it 'should install packages for development' do
    expect(chef_run).to install_package('vim')
    expect(chef_run).to install_package('git-core')
    expect(chef_run).to install_package('git-doc')
  end

  it 'should install packages for screenshot comparison' do
    expect(chef_run).to install_package('libmagickwand-dev')
  end

  it 'should install packages for nokogiri' do
    expect(chef_run).to install_package('libxml2-dev')
    expect(chef_run).to install_package('libxslt-dev')
  end

  it 'should install packages for node:grunt' do
    expect(chef_run).to install_package('fontforge')
    expect(chef_run).to install_package('ttfautohint')
  end
end