# Public: Install and configure git from homebrew.
#
# Examples
#
#   include git
class git {
  include boxen::config

  $configdir = "${boxen::config::configdir}/git"
  $credentialhelper = "${boxen::config::repodir}/script/boxen-git-credential"

  package { 'boxen/brews/git':
    ensure => '1.7.10.4-boxen1'
  }

  file { $configdir:
    ensure => directory
  }

  file { $credentialhelper:
    ensure => link,
    target => "${boxen::config::home}/bin/boxen-git-credential",
    before => Package['boxen/brews/git']
  }

  file { "${configdir}/gitignore":
    source  => 'puppet:///modules/git/gitignore',
    require => File[$configdir]
  }

  git::config::global{ 'credential.helper':
    value => $credentialhelper
  }

  git::config::global{ 'core.excludesfile':
    value   => "${configdir}/gitignore",
    require => File["${configdir}/gitignore"]
  }

  if $::gname {
    git::config::global{ 'user.name':
      value => $::gname
    }
  }

  if $::gemail {
    git::config::global{ 'user.email':
      value => $::gemail
    }
  }
}
