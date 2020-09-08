#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table calculation_correction (
    calcset varchar(20) character set latin1 not null,
    corr_index tinyint(4) not null default '0',
    isobar_fact double default null,
    isobar_err double default null,
    std_ra double default null,
    std_ra_err double default null,
    std_ba double default null,
    std_ba_err double default null,
    bl_ra double default null,
    bl_ra_err double default null,
    a_slope double default null,
    a_slope_off double default null,
    b_slope double default null,
    b_slope_off double default null,
    time_corr double default null,
    first_run varchar(12) character set latin1 default null,
    last_run varchar(12) character set latin1 default null,
    bg_const double default '0',
    bg_const_err double default '0',
    bl_const double default '0',
    bl_const_err double default '0',
    bl_const_mass double default '0',

    primary key (calcset, corr_index),

    constraint calculation_correction_set_foreign_key
    foreign key (calcset)
    references calculation_set (calcset) on update cascade
) engine=innodb;
