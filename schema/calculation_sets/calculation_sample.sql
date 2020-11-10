#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table calculation_sample (
    calcset varchar(20) character set latin1 not null,

    isotope_number int not null,
    sample_number int(5) not null,
    preparation_number int(5) not null,
    target_number int(5) not null,

    type varchar(20) character set latin1 default null,
    prep_bl double not null default '0',
    active smallint(6) not null default '1',
    std_bl smallint(6) default null,

    primary key (calcset, target_number, sample_number, preparation_number, isotope_number),

    # TODO ewc 2020-11-09: foreign key auf target (via iso, sample, prep, target) & validate

    constraint calculation_sample_set_foreign_key
    foreign key (calcset)
    references calculation_set (calcset) on update cascade
) engine=innodb;
