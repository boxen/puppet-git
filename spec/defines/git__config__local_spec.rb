require 'spec_helper'

describe 'git::config::local' do
  let(:title) { '/tmp/test' }
  let(:params) do
    {
      :key    => 'user.name',
      :value  => 'Hugh Bot',
      :ensure => 'present',
    }
  end
  let(:facts) { default_test_facts }

  it do
    namevar = "set #{params[:key]} to #{params[:value]} in #{title}"
    should contain_ini_setting(namevar).with({
      :ensure  => params[:ensure],
      :path    => "#{title}/.git/config",
      :section => 'user',
      :setting => 'name',
      :value   => params[:value],
    })
  end
end
