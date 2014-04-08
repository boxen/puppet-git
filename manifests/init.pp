# Public: Install and configure git from homebrew.
#
# Examples
#
#   include git
class git (
  $package                 = $git::params::package,
  $version                 = $git::params::version,
  $configdir               = $git::params::configdir,
  $credentialhelper        = $git::params::credentialhelper,
  $global_credentialhelper = $git::params::global_credentialhelper,
  $global_excludesfile     = $git::params::global_excludesfile,
) inherits git::params {
  include homebrew
  include git::config

  homebrew::formula { 'git':
    before => Package[$package]
  }

  package { $package:
    ensure => $version,
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
    before  => Package[$package],
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
    value   => $global_excludesfile,
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
