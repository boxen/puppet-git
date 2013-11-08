# Public: Install (and configure) git
#

class git(
  $ensure                  = $git::params::ensure,

  $package                 = $git::params::package,
  $version                 = $git::params::version,
) inherits git::params {

  $package_ensure = $ensure ? {
    present => $version,
    default => absent,
  }

  if $::operatingsystem == 'Darwin' {
    class { 'git::operatingsystem::darwin':
      ensure => $ensure,
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

}
