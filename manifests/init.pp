# Public: Install and configure git from homebrew.
#
# Examples
#
#   include git
class git {
  include boxen::config

  $configdir = "${boxen::config::configdir}/git"
  $credentialhelper = "${boxen::config::repodir}/script/boxen-git-credential"
  $global_credentialhelper = "${boxen::config::home}/bin/boxen-git-credential"

  package { 'boxen/brews/git':
    ensure => '1.8.0-boxen1'
  }

  file { $configdir:
    ensure => directory
  }

  file { $credentialhelper:
    ensure => file
  }

  file { $global_credentialhelper:
    ensure  => link,
    target  => $credentialhelper,
    before  => Package['boxen/brews/git'],
    require => File[$credentialhelper]
  }

  file { "${configdir}/gitignore":
    source  => 'puppet:///modules/git/gitignore',
    require => File[$configdir]
  }

  git::config::global{ 'credential.helper':
    value => $global_credentialhelper
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
