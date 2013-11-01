# Public: Set a git configuration option for a specific repository.
#
# namevar - The String path to the git repository (if repo is not defined).
# repo    - The String path to the git repository.
# key     - The String name of the configuration option.
# value   - The String value of the configuration option.
# ensure  - The desired state of the resource as a String.  Valid values are
#           'present' and 'absent' (default: 'present').
#
# Examples
#
#   git::config::local { '/tmp/foo':
#     key   => 'user.name',
#     value => 'Hugh Bot',
#   }
define git::config::local($key, $value, $repo = $name, $ensure = present) {
  $split_key = split($key, '\.')

  ini_setting { "set ${key} to ${value} in ${repo}":
    ensure  => $ensure,
    path    => "${repo}/.git/config",
    section => $split_key[0],
    setting => $split_key[1],
    value   => $value
  }
}
