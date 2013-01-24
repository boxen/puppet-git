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

  it do
    should include_class('homebrew')
    should include_class('git::config')

    should contain_homebrew__formula('git')

    should contain_package('boxen/brews/git').with_ensure('1.8.0-boxen1')

    should contain_file(configdir).with_ensure('directory')

    should contain_file("#{boxenhome}/bin/boxen-git-credential").with({
      :ensure => 'link',
      :target => "#{repodir}/script/boxen-git-credential",
    })

    should contain_file("#{configdir}/gitignore").with({
      :source  => 'puppet:///modules/git/gitignore',
      :require => "File[#{configdir}]",
    })

    should contain_git__config__global('credential.helper').with({
      :value => "#{boxenhome}/bin/boxen-git-credential",
    })

    should contain_git__config__global('core.excludesfile').with({
      :value   => "#{configdir}/gitignore",
      :require => "File[#{configdir}/gitignore]",
    })


    should_not contain_git__config__global('user.name')
    should_not contain_git__config__global('user.email')
  end

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
