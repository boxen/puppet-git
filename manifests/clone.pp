# Clones a specific git repository
#
# Usage:
#    git::clone{"https://github.com/my/repo":
#       path   => "/path/to/where/clone/goes",
#       target => "name_to_clone_into"
#
# Note:
#   You SHOULD use HTTPS as the transport for your git repos. If you choose not
#   to, be sure to specificy a target value or your repo will be cloned into an
#   odd location

define git::clone(
  $path,
  $target = ''
){
  require boxen::config

  $repo_name = $name ? {
    /^https.*\.git$/ => regsubst($name, '^https:.*/([^/]+)\.git$', '\1'),
    /^https.*[^\/]$/ => regsubst($name, '^https:.*/([^/]+)$', '\1'),
    /\.git$/         => regsubst($name, '.*/([^/]+)\.git$', '\1'),
    default          => fail("Unable to parse out repo name: ${name}")
  }

  $clone_tgt = $target ? {
    ''      => "${path}/${repo_name}",
    default => "${path}/${target}"
  }
  if !defined(File[$path]){
    file{$path:
      ensure => directory,
      owner  => $::luser,
      mode   => '0700'
    }
  }

  exec{"git clone ${name}":
    cwd       => $path,
    path      => "${boxen::config::homebrewdir}/bin",
    user      => $::luser,
    logoutput => true,
    command   => "hub clone ${name} ${clone_tgt}",
    creates   => $clone_tgt,
    require   => [Class['git'], File[$path]],
    timeout   => 0
  }
}

