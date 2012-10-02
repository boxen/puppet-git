define git::config::local($key, $value, $ensure = present) {
  $split_key = split($key, '\.')

  ini_setting { "set ${key} to ${value} in ${name}":
    ensure  => $ensure,
    path    => "${name}/.git/config",
    section => $split_key[0],
    setting => $split_key[1],
    value   => $value
  }
}
