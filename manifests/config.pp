# Public: Include shared variables for working with git
#
# Usage:
#
#   include git::config

class git::config {
  include boxen::config

  $configdir = "${boxen::config::configdir}/git"
  $credentialhelper = "${boxen::config::repodir}/script/boxen-git-credential"
  $global_credentialhelper = "${boxen::config::home}/bin/boxen-git-credential"

  $version = '1.8.2.3-boxen1'


  anchor { [
    $configdir,
    $credentialhelper,
    $global_credentialhelper,
  ]: }
}
