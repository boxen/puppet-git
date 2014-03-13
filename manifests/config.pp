# Public: Include shared variables for working with git
#
# Usage:
#
#   include git::config

class git::config inherits git::params {
  anchor { [
    $git::params::configdir,
    $git::params::credentialhelper,
    $git::params::global_credentialhelper,
    $git::params::global_excludesfile,
  ]: }
}
