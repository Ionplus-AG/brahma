#
# copyright (c) Ionplus AG and contributors. all rights reserved.
# licensed under the mit license. see license file in the project root for details.
#

create table isotope (
    number int primary key auto_increment,
    name varchar(20) unique not null,
    name_markup varchar(30) not null
) engine=innodb;
