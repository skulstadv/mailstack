# Class for managing postfix
class mailstack::postfix {


  # Copy premade certificate *THIS MUST BE CHANGED BY USER*
  file { "/etc/ssl/certs/dovecot.pem":
    ensure   => 'present',
    source   => "puppet:///modules/mailstack/postfix/ssl/certs/dovecot.pem",
  }


  # Copy premade certificate *THIS MUST BE CHANGED BY USER*
  file { "/etc/ssl/private/dovecot.pem":
    ensure   => 'present',
    source   => "puppet:///modules/mailstack/postfix/ssl/private/dovecot.pem",
  }


  # Install postfix-mysql package
  package { 'postfix-mysql':
    ensure => 'present'
  }


  # Manage postfix installation
  class { 'postfix':
    config_file_source => "puppet:///modules/mailstack/postfix/main/main.cf",
  }


  # Copy postfix config files
  file { "/etc/postfix/":
    ensure   => 'directory',
    source   => "puppet:///modules/mailstack/postfix",
    recurse  => 'remote',
  }


# These functions are handy for testing your configuration
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
