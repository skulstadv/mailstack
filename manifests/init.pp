# Class: mailstack
# ===========================
#
# Class for managing postfix, dovecot and mysql
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `db_root_password`
# The password to be set for the MySQL root user.
# * `db_username`
# The username in the MySQL database for the mail user
# * `db_password`
# The password in the MySQL database for the mail user

class mailstack (
  $db_root_password    = 'root',
  $db_username         = 'usermail',
  $db_password         = 'mailpassword',

){
  #The mysql database is managed
  class { 'mailstack::db': }

  # Then postfix is managed after mysql database
  class { 'mailstack::postfix':
    require => Class['mailstack::db'],
  }

  # Then dovecot is managed after postfix
  class { 'mailstack::dovecot':
    require => Class['mailstack::postfix'],
  }
}
