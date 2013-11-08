# Internal: defaults

class git::params {

  $ensure = present

  case $::operatingsystem {
    Darwin: {
      include boxen::config

      $package                 = 'boxen/brews/git'
      $version                 = '1.8.4-boxen1'
    }

    Ubuntu: {
      $package                 = 'git-core'
      $version                 = 'installed'
    }

    default: {
      fail('Unsupported operating system!')
    }
  }

}
