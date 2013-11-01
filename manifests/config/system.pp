# Public: Set a system git configuration value.
#
# namevar - The String name of the configuration option.
# value   - The String value of the configuration option.
#
# Examples
#
#   git::config::system { 'http.proxy':
#     value => 'proxy.corporate.com:80',
#   }
#
#   git::config::system { 'http.sslVerify':
#     value => 'false',
#   }
define git::config::system($value) {
  $split_key = split($name, '\.')
  $section = join(delete_at($split_key, size($split_key) - 1), '.')
  $setting = $split_key[-1]
  $path = '/etc/gitconfig'

  ini_setting { "set ${name} to ${value} in ${path}":
    ensure  => present,
    path    => $path,
    section => $section,
    setting => $setting,
    value   => $value,
  }
}
