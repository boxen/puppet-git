define git::config::global($value) {
  $split_key = split($name, '\.')
  $path = "/Users/${::luser}/.gitconfig"

  ini_setting { "set ${name} to ${value} in ${path}":
    path    => $path,
    section => $split_key[0],
    setting => $split_key[1],
    value   => $value,
    ensure  => present
  }
}
