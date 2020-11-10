#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table calculation_set (
    calcset varchar(20) character set latin1 not null,
    a_off double default null,
    a_err_abs double default null,
    a_err_rel double default null,
    b_off double default null,
    b_err_abs double default null,
    b_err_rel double default null,
    iso_off double default null,
    iso_err_abs double default null,
    iso_err_rel double default null,
    isobar varchar(20) character set latin1 default null,
    magazine varchar(12) character set latin1 default null,
    date_calc timestamp not null default current_timestamp,
    user_calc varchar(20) character set latin1 default null,
    charge tinyint(4) default null,
    first_run varchar(12) character set latin1 default null,
    last_run varchar(12) character set latin1 default null,
    comment text character set latin1,
    fract tinyint(1) default '1',
    edit tinyint(1) default '1',
    deadtime double default null,
    scatter double default null,
    weighting tinyint(4) not null default '0',
    poisson tinyint(4) not null default '1',
    cycles smallint(6) not null default '0',
    ra_norm double not null default '1',
    ba_norm double not null default '0.975',

    primary key (calcset),
    key calculation_set_magazine_key (magazine)
) engine=innodb;
