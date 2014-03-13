require 'spec_helper'

describe 'git::config::system' do
  let(:title) { 'http.proxy' }
  let(:params) { { :value => 'proxy.corporate.com:80' } }
  let(:path) { '/etc/gitconfig' }

  it do
    should contain_ini_setting("set #{title} to #{params[:value]} in #{path}").with({
      :path    => path,
      :section => 'http',
      :setting => 'proxy',
      :value   => params[:value],
      :ensure  => 'present',
    })
  end
end
