#!/usr/bin/perl
use v5.10.1;

BEGIN { 
    push @INC, '/app/src';
}

use Library::DB;

my $db = Library::DB->get_instance();

print("Creating customers table...\r\n");

$db->query("DROP TABLE IF EXISTS `customers`;");
$db->query("CREATE TABLE IF NOT EXISTS `customers` (
    `id`         INT(10) UNSIGNED NOT NULL auto_increment,
    `name`       VARCHAR(128) NOT NULL,
    `birth_date` DATE NOT NULL,
    `cpf`        VARCHAR(11) NOT NULL,
    `rg`         VARCHAR(9) NOT NULL,
    `phone`      VARCHAR(11) NOT NULL,
    PRIMARY KEY (`id`)
) engine = innodb; ");

$db->query("INSERT INTO `customers` (`name`, `birth_date`, `cpf`, `rg`, `phone`) VALUES (
    'Nathan Soares', '1995-09-11', '00000000000', '000000000', '18981496666'
);");

$db->query("INSERT INTO `customers` (`name`, `birth_date`, `cpf`, `rg`, `phone`) VALUES (
    'Nathan Oliveira', '1995-08-10', '00000000000', '000000000', '18981497777'
);");