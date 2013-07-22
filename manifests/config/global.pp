# Public: Set a global git configuration value.
#
# namevar - The String name of the configuration option.
# value   - The String value of the configuration option.
#
# Examples
#
#   git::config::global { 'user.name':
#     value => 'Hugh Bot',
#   }
#
#   git::config::global { 'user.email':
#     value => 'test@example.com',
#   }
define git::config::global($value) {
  $split_key = split($name, '\.')
  $path = "/Users/${::boxen_user}/.gitconfig"

  ini_setting { "set ${name} to ${value} in ${path}":
    ensure  => present,
    path    => $path,
    section => $split_key[0],
    setting => $split_key[1],
    value   => $value,
  }
}
