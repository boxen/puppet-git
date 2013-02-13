# Git Puppet Module for Boxen

Install [Git](http://git-scm.com), a stupid content tracker.

## Usage

```puppet
include git

git::config:local { '/path/to/my/repo':
  ensure => present,
  key    => 'user.email',
  value  => 'turnt@example.com'
}

git::config::global { 'user.email':
  value  => 'turnt@example.com'
}
```

## Required Puppet Modules

* `boxen`
* `homebrew`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
