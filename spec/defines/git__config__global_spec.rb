require 'spec_helper'

describe 'git::config::global' do
  let(:title) { 'user.name' }
  let(:params) { {:value => 'Hugh Bot'} }
  let(:facts) { default_test_facts }

  let(:path) { '/Users/hubot/.gitconfig' }

  it do
    should contain_ini_setting("set #{title} to #{params[:value]} in #{path}").with({
      :path    => path,
      :section => 'user',
      :setting => 'name',
      :value   => params[:value],
      :ensure  => 'present',
    })
  end
end
