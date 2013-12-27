# Git Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-git.png)](https://travis-ci.org/boxen/puppet-git)

Install [Git](http://git-scm.com), a stupid content tracker.

## Usage

```puppet
include git

git::config::local { 'repo_specific_email':
  ensure => present,
  repo   => '/path/to/my/repo',
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
* `ini_setting`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
