# Set up regular Puppet runs
file { '/usr/local/bin/run-puppet':
  source => '/etc/puppetlabs/code/environments/production/files/run-puppet.sh',
  mode   => '0755',
}

cron { 'run-puppet':
  command => '/usr/local/bin/run-puppet',
  hour    => '*',
  minute  => '*/5',
}

package { 'ruby':
  ensure => installed,
}

package { 'puppet-lint':
  ensure   => installed,
  provider => gem,
}

user { 'guido':
  ensure => present,
  uid    => '3001',
  home   => '/home/guido',
  shell  => '/bin/bash',
}


file { '/home/guido/.ssh':
  ensure => 'directory',
  user =>   'guido',
  group =>  'guido',
  mode =>   '0700'
}

ssh_authorized_key { 'guizzunti':
  user => 'guido',
  type => 'ssh-dss',
  key  => 'AAAAB3NzaC1kc3MAAACBALVspOaAJ+SLJUt8vVfDGfllpUNMObc/HCAFk/HJjbg5MnVDKcMSnukhetD+40CCZooNp/S7gt4X9yVGFUq2esR/pf3XWixhrNSltD/ndmpHdkTXsaXqykBl6hKGZA4UwAvpFn20Ucbr7suTHRFTvo9rNawmnb5CJWbracsW7W6BAAAAFQDAb882CknfZWP+DSzAvTOJBg2TnQAAAIB+EwN9nw9j9v5IsQyJ+jDmwDK8U0z8Cwbl9htnq4CugP9wfrK4IcAibUvBnKMqd1scdarVrP35U0wOKmkH1yyjr94ymDvTQuxWGa6akl1LVEU2kqtDZ/ozknvw5eiTtySDACVArPNTX+pTSe0G1VJU0FaeVR5jvlmELVRVODDUOAAAAIEAj3rEkf9eFfemgFbAoWoPF3lc6WMr463MccHUbIbRV+mOdGWKm9nTMkZWJg4AVx3cmeSUy5a9P0H5Y4UvOwJWuhlKa8PpB74HCCLPrVOtkxKEm6UURZwR5dG8TCteqwxLd+Bg4t06zIpADf2GLGjn/G1jAAOup2oluCax/kJZ7NU=',
}
