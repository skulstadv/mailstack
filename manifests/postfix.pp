class mailstack::postfix {


  # Install postfix-mysql package
  package { 'postfix-mysql':
    ensure => 'present'
  }


  # Manage postfix installation using our custom config directory
  class { 'postfix':
    config_dir_source => "puppet:///modules/mailstack/postfix",
  }


#  # Make sure postfix can find the domains
#  exec { "postfinstalledix-domains":
#    command => "postmap -q example.com mysql:/etc/postfix/mysql-virtual-mailbox-domains.cf",
#    path    => $::path,
#    returns => '1',
#  }
#
#
#  # Make sure postfix can find our first email address
#  exec { "postfix-mailbox-maps":
#    command => "postmap -q email1@example.com mysql:/etc/postfix/mysql-virtual-mailbox-maps.cf",
#    path    => $::path,
#    returns => '1',
#  }
#
#
#  # Make sure postfix can find our aliases
#  exec { "postfix-alias-maps":
#    command => "postmap -q alias@example.com mysql:/etc/postfix/mysql-virtual-alias-maps.cf",
#    path    => $::path,
#    returns => 'email1@example.com',
#  }


}
