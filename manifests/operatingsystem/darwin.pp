class git::operatingsystem::darwin(
  $ensure = $git::params::ensure,
) inherits git::params {

  if $::operatingsystem != 'Darwin' {
    fail('Invalid operating system!')
  }

  $dir_ensure = $ensure ? {
    present => directory,
    default => absent,
  }

  $link_ensure = $ensure ? {
    present => link,
    default => absent,
  }

  include boxen::config


  $configdir                = "${boxen::config::configdir}/git"
  $credential_helper        = "${boxen::config::repodir}/script/boxen-git-credential"
  $global_credential_helper = "${boxen::config::bindir}/boxen-git-credential"

  homebrew::formula { 'git': }

  file {
    $configdir:
      ensure => $dir_ensure ;

    $credential_helper:
      ensure => $ensure ;

    $global_credential_helper:
      ensure  => $link_ensure,
      target  => $credential_helper ;

    "${configdir}/gitignore":
      source  => 'puppet:///modules/git/gitignore' ;
  }

  git::config::global {
    'credential.helper':
      value => $global_credential_helper ;

    'core.excludesfile':
      value => "${configdir}/gitignore" ;
  }

}
