# mailstack

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with mailstack](#setup)
    * [What mailstack affects](#what-mailstack-affects)
    * [Beginning with mailstack](#beginning-with-mailstack)
1. [Usage - Configuration options and additional functionality](#usage)

## Description

This module installs and configures Postfix, Dovecot and MySQL for use as a mail server on ubuntu 18.04 for puppet version >= 5.3.7

## Setup

### What mailstack affects

The following changes will be made to the system:

* A vmail group will be created with id 5000
* A vmail user will be created and added to the vmail group
  impact, or execute.

This puppet module depends on the following modules which will be installed:
* puppetlabs-stdlib
* dhoppe-postfix
* example42-firewall
* example42-iptables
* example42-monitor
* example42-mysql
* example42-puppi
* puppet-extlib
* puppetlabs-concat
* um-dovecot

### Beginning with mailstack

If all the configuration files in the /files/ directory are left unaltered and the module is installed without parameters the settings will be:

MySQL:
* Root password = 'root'
* Mail authentication user username = 'usermail'
* Mail authentication user password = 'mailpassword'
* Datbase name = 'servermail'
* Primary domain = 'example.com'
* FQDN = 'hostname.example.com'

Email accounts:
* Email =  'email1@example.com', password = 'firstpassword'
* Email =  'email2@example.com', password = 'secondpassword'

Postfix and dovecot will be using all the same defaults as specified above in MySQL.

## Usage

* Install mailstack with default settings (not recommended)

        class { 'mailstack': }

* Use custom MySQL root password, mail authentication user username and password

        class { 'mailstack':
          db_root_password  => '<your root password>',
          db_username       => '<your db username>',
          db_password       => '<your db password>',
        }

* When customizing email users and domains every occurence of the defaults in the .sql statements and config files in /files/ and subfolders should be replaced by the desired values

* A new certificate for dovecot should be generated and put on the master in puppet::/module/mailstack/files/dovecot/ssl or generated on the agent like this:
        openssl req -new -x509 -days 1000 -nodes -out "/etc/ssl/certs/dovecot.pem" -keyout "/etc/ssl/private/dovecot.pem"

* The above certificate would be self signed, it is preferable to get a certificate from for instance letsencrypt.org that isnt self signed


