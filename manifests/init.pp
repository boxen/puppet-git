# Public: Install and configure git from homebrew.
#
# Examples
#
#   include git
class git (
  $package                 = $git::package,
  $version                 = $git::version,
  $configdir               = $git::configdir,
  $credentialhelper        = $git::credentialhelper,
  $global_credentialhelper = $git::global_credentialhelper,
  $global_excludesfile     = $git::global_excludesfile,
) {
  if $::osfamily == 'Darwin' {
    include boxen::config
    include homebrew

    homebrew::formula { 'git':
      before => Package[$package]
    }

    package { $package:
      ensure   => $version,
      provider => homebrew
    }
  } else {
    package { $package:
      ensure => $version
    }
  }

  file { $configdir:
    ensure => directory
  }

  if $credentialhelper {
    file { $credentialhelper:
      ensure => file
    }
  }

  if $global_credentialhelper {
    file { $global_credentialhelper:
      ensure  => link,
      target  => $credentialhelper,
      before  => Package[$package],
      require => File[$credentialhelper]
    }

    git::config::global{ 'credential.helper':
      value => $global_credentialhelper
    }
  }

  file { "${configdir}/gitignore":
    source  => 'puppet:///modules/git/gitignore',
    require => File[$configdir]
  }

  if $global_excludesfile {
    git::config::global{ 'core.excludesfile':
      value   => $global_excludesfile,
      require => File["${configdir}/gitignore"]
    }
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
