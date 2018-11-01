class mailstack::db {


  # Get variable values from mailstack main class
  $db_root_password = $mailstack::db_root_password
  $db_username = $mailstack::db_username
  $db_password = $mailstack::db_password


  # Set root password on mysql database
  class { 'mysql':
    root_password =>  $db_root_password,
  }


  # Copy SQL statements from puppet master and save to tmp
  file { "/tmp/sql/":
    ensure   => 'directory',
    source   => "puppet:///modules/mailstack/sql",
    recurse   => 'remote',
  }


  # Create database, user and domains table
  mysql::grant { 'servermail':
    mysql_db                  => 'servermail',
    mysql_user                => $db_username,
    mysql_password            => $db_password,
    mysql_privileges          => 'SELECT',
  }


  # Create table domains
  mysql::queryfile { 'create_table_domains.sql':
    mysql_file                => '/tmp/sql/create_table_domains.sql',
    mysql_db                  => 'servermail',
    mysql_user                => 'root',
    mysql_password            => $db_root_password,
    mysql_host                => 'localhost',
  }


  # Create database users
  mysql::queryfile { 'create_table_users.sql':
    mysql_file                => '/tmp/sql/create_table_users.sql',
    mysql_db                  => 'servermail',
    mysql_user                => 'root',
    mysql_password            => $db_root_password,
    mysql_host                => 'localhost',
  }


  # Create database aliases
  mysql::queryfile { 'create_table_aliases.sql':
    mysql_file                => '/tmp/sql/create_table_aliases.sql',
    mysql_db                  => 'servermail',
    mysql_user                => 'root',
    mysql_password            => $db_root_password,
    mysql_host                => 'localhost',
  }


  # Create virtual domains
  mysql::queryfile { 'virtual_domains.sql':
    mysql_file                => '/tmp/sql/virtual_domains.sql',
    mysql_db                  => 'servermail',
    mysql_user                => 'root',
    mysql_password            => $db_root_password,
    mysql_host                => 'localhost',
  }


  # Create virtual emails
  mysql::queryfile { 'virtual_emails.sql':
    mysql_file                => '/tmp/sql/virtual_emails.sql',
    mysql_db                  => 'servermail',
    mysql_user                => 'root',
    mysql_password            => $db_root_password,
    mysql_host                => 'localhost',
  }


  # Create virtual aliases
  mysql::queryfile { 'virtual_aliases.sql':
    mysql_file                => '/tmp/sql/virtual_aliases.sql',
    mysql_db                  => 'servermail',
    mysql_user                => 'root',
    mysql_password            => $db_root_password,
    mysql_host                => 'localhost',
  }


}
