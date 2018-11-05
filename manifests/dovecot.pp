class mailstack::dovecot {


  # Install dovecot imapd, lmtpd and mysql packages
  package { [ 'dovecot-imapd',
              'dovecot-lmtpd',
              'dovecot-mysql', ]:
    ensure => 'present'
  }


  # Make vmail group with id 5000
  exec { 'vmail group':
    command => 'groupadd -g 5000 vmail',
    path    => $::path,
    returns => ['1', '9'],
  }


  # Make vmail user
  exec { 'vmail user':
    command => 'useradd -g vmail -u 5000 vmail -d /var/mail',
    path    => $::path,
    returns => ['1', '9'],
  }


  # Change owner of /var/mail to vmail
  exec { 'owner var/mail':
    command => 'chown -R vmail:vmail /var/mail',
    path    => $::path,
  }


  # Change owner of dovecot folder to vmail
  exec { 'owner /etc/dovecot':
    command => 'chown -R vmail:dovecot /etc/dovecot',
    path    => $::path,
  }


  # Change group of dovecot folder to vmail
  exec { 'group /etc/dovecot':
    command => 'chmod -R o-rwx /etc/dovecot',
    path    => $::path,
}

  # Create directory structure
  file { ['/var/mail/vhosts',
          '/var/mail/vhosts/example.com', ]:
    ensure  => 'directory',
  }


  # Change owner of /var/mail/* to vmail
  exec { 'owner var/mail':
    command => 'chown -R vmail:vmail /var/mail/*',
    path    => $::path,
  }


  # Change owner of /var/mail/*/* to vmail
  exec { 'owner var/mail':
    command => 'chown -R vmail:vmail /var/mail/*/*',
    path    => $::path,
  }


  # Manage dovecot installation
  class { 'dovecot':
  }


  # Copy dovecot config files
  file { "/etc/dovecot/":
    ensure   => 'directory',
    source   => "puppet:///modules/mailstack/dovecot",
    recurse  => 'remote',
  }


  # Copy dovecot config files
  file { "/etc/dovecot/conf.d/":
    ensure   => 'directory',
    source   => "puppet:///modules/mailstack/dovecot/conf.d",
    recurse   => 'remote',
  }


}
