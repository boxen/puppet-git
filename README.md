# Git Puppet Module for Boxen

Requires the following boxen modules:

* `boxen`
* `homebrew`

## Usage

```puppet
include git

git::config:local { '/path/to/my/repo':
  ensure => present,
  key    => 'user.email',
  value  => 'awesome@thebomb.com'
}

git::config::global { 'user.email':
  value  => 'awesome@thebomb.com'
}
```
