require 'spec_helper'

describe 'git' do
  let(:boxenhome) { '/opt/boxen' }
  let(:configdir) { "#{boxenhome}/config/git" }
  let(:repodir) { "#{boxenhome}/repo" }
  let(:facts) do
    default_test_facts.merge({
      :boxen_home    => boxenhome,
      :boxen_repodir => repodir,
    })
  end

  let(:default_params) do
    {
      :configdir               => configdir,
      :package                 => 'boxen/brews/git',
      :version                 => '2.3.0',
      :global_credentialhelper => "#{boxenhome}/bin/boxen-git-credential",
      :credentialhelper        => "#{repodir}/script/boxen-git-credential",
      :global_excludesfile     => '/opt/boxen/config/git/gitignore'
    }
  end

  let(:params) { default_params }

  it do
    should include_class('homebrew')

    should contain_homebrew__formula('git')

    should contain_package('boxen/brews/git').with({
      :ensure => '2.3.0',
      :provider => 'homebrew',
    })

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

  context "Linux" do
    let(:facts) { default_test_facts.merge(:osfamily => 'Linux') }

    it do
      should contain_package('boxen/brews/git').with({
        :ensure => '2.3.0',
        :provider => nil,
      })
    end
  end

  context 'when the global_excludesfile parameter is set' do
    let(:params) { default_params.merge({ :global_excludesfile => '/some/other/file' }) }

    it do
      should contain_git__config__global('core.excludesfile').with({
        :value => '/some/other/file'
      })
    end
  end

  context 'when the global_excludesfile parameter is set to false' do
    let(:params) { default_params.merge({ :global_excludesfile => false }) }

    it do
      should_not contain_git__config__global('core.excludesfile')
    end
  end

  context 'when gname fact is set' do
    let(:facts) do
      default_test_facts.merge({
        :boxen_home    => boxenhome,
        :boxen_repodir => repodir,
        :gname         => 'Hugh Bot',
      })
    end

    it do
      should contain_git__config__global('user.name').with({
        :value => 'Hugh Bot',
      })
    end
  end

  context 'when gemail fact is set' do
    let(:facts) do
      default_test_facts.merge({
        :boxen_home    => boxenhome,
        :boxen_repodir => repodir,
        :gemail        => 'test@example.com',
      })
    end

    it do
      should contain_git__config__global('user.email').with({
        :value => 'test@example.com',
      })
    end
  end
end
