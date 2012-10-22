require 'spec_helper'

describe 'git' do
  let(:boxenhome) { '/opt/boxen' }
  let(:configdir) { "#{boxenhome}/config/git" }
  let(:repodir) { "#{boxenhome}/repo" }
  let(:facts) do
    {
      :boxen_home    => boxenhome,
      :boxen_repodir => repodir,
    }
  end

  it { should include_class('boxen::config') }
  it do
    should contain_package('boxen/brews/git').with_ensure('1.8.0-boxen1')
  end

  it { should contain_file(configdir).with_ensure('directory') }

  it do
    should contain_file("#{boxenhome}/bin/boxen-git-credential").with({
      :ensure => 'link',
      :target => "#{repodir}/script/boxen-git-credential",
    })
  end

  it do
    should contain_file("#{configdir}/gitignore").with({
      :source  => 'puppet:///modules/git/gitignore',
      :require => "File[#{configdir}]",
    })
  end

  it do
    should contain_git__config__global('credential.helper').with({
      :value => "#{boxenhome}/bin/boxen-git-credential",
    })
  end

  it do
    should contain_git__config__global('core.excludesfile').with({
      :value   => "#{configdir}/gitignore",
      :require => "File[#{configdir}/gitignore]",
    })
  end

  it { should_not contain_git__config__global('user.name') }
  it { should_not contain_git__config__global('user.email') }

  context 'when gname fact is set' do
    let(:facts) do
      {
        :boxen_home    => boxenhome,
        :boxen_repodir => repodir,
        :gname         => 'Hugh Bot',
      }
    end

    it do
      should contain_git__config__global('user.name').with({
        :value => 'Hugh Bot',
      })
    end
  end

  context 'when gemail fact is set' do
    let(:facts) do
      {
        :boxen_home    => boxenhome,
        :boxen_repodir => repodir,
        :gemail        => 'test@example.com',
      }
    end

    it do
      should contain_git__config__global('user.email').with({
        :value => 'test@example.com',
      })
    end
  end
end
