require 'spec_helper'

describe 'git::config::system' do
  let(:proxy) { { :proxy => 'proxy.corporate.com:80' } }
  let(:path) { '/etc/gitconfig' }

  it do
    should contain_ini_setting("set #{title} to #{params[:value]} in #{path}").with({
      :path    => path,
      :section => 'user',
      :setting => 'http.proxy',
      :value   => params[:proxy],
      :ensure  => 'present',
    })
  end
end
