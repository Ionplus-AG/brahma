#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table customer (
    number int auto_increment primary key,
    first_name varchar(40),
    last_name varchar(60) not null,
    organisation varchar(255),
    institute varchar(255),
    address_1 varchar(80),
    address_2 varchar(80),
    town varchar(30),
    postcode varchar(10),
    country varchar(30),
    phone_1 varchar(30),
    phone_2 varchar(30),
    fax varchar(30),
    email varchar(80),
    www varchar(60),
    account varchar(40),
    is_invoice bool default true, # TODO, ewc 2020-07-31: default false? not null?
    is_correspondence bool default true, # TODO, ewc 2020-07-31: default false? not null?
    comment text,
    language varchar(2),
    title varchar(20),
    salutation varchar(10)
) engine=innodb;
