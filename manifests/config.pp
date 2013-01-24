class git::config {
  require boxen::config

  $configdir = "${boxen::config::configdir}/git"
  $credentialhelper = "${boxen::config::repodir}/script/boxen-git-credential"
  $global_credentialhelper = "${boxen::config::home}/bin/boxen-git-credential"


  anchor { [
    $configdir,
    $credentialhelper,
    $global_credentialhelper,
  ]: }
}
