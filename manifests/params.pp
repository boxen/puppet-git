# Internal: defaults
class git::params {

  case $::operatingsystem {
    Darwin: {
      include boxen::config

      $configdir = "${boxen::config::configdir}/git"
      $credentialhelper = "${boxen::config::repodir}/script/boxen-git-credential"
      $global_credentialhelper = "${boxen::config::home}/bin/boxen-git-credential"

      $version = '1.8.4-boxen2'
    }

    default: {
      fail('Unsupported operating system!')
    }
  }

  $ensure = present
  $host   = $::ipaddress_lo0
  $enable = true

}
