require 'spec_helper'

describe 'git::config' do
  let(:boxenhome) { '/opt/boxen' }
  let(:configdir) { "#{boxenhome}/config/git" }
  let(:repodir) { "#{boxenhome}/repo" }
  let(:facts) do
    {
      :boxen_home    => boxenhome,
      :boxen_repodir => repodir,
      :boxen_user    => 'wfarr',
    }
  end

  it do
    should contain_anchor('/opt/boxen/config/git')
    should contain_anchor('/opt/boxen/repo/script/boxen-git-credential')
    should contain_anchor('/opt/boxen/bin/boxen-git-credential')
  end
end