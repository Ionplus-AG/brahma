#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table sample (
    number int not null,
    isotope_number int not null,
    project_number int not null,
    photo varchar(120) default null, # TODO, ewc 2020-08-21: what is stored in this field?
    type varchar(20) not null default 'sample',
    material varchar(20) default null,
    fraction varchar(20) default null,
    pre_sub_treat varchar(40) default null, # TODO, ewc 2020-08-21: improve naming; what is stored in this field?
    weight double default null,
    preparation varchar(100) default null,
    sampling_date date default null,
    editable bool not null default true,
    not_to_be_dated bool not null default false,
    user_label varchar(40) default null,
    user_label_number varchar(40) default null,
    user_description1 varchar(255) default null,
    user_description2 varchar(255) default null,
    residue double default null,
    c14_age double default null,
    c14_age_sigma double default null,
    av_fm double default null,
    av_fm_sigma double default null,
    av_dc13 double default null,
    av_dc13_sigma double default null,
    av_dc13_irms double default null,
    cal1s_min int default null,
    cal1s_max int default null,
    cal2s_min int default null,
    cal2s_max int default null,
    cal_curve varchar(20) default null,
    delta_r int default null,
    calibration varchar(120) default null,
    old_info varchar(70) default null, # TODO, ewc 2020-08-21: what is stored in this field?
    user_comment varchar(100) default null,

    primary key (isotope_number, number),

    constraint isotope_foreign_key
    foreign key (isotope_number) references isotope(number),

    constraint project_foreign_key
    foreign key (project_number) references project(number),

    constraint sample_type_foreign_key
    foreign key (type) references sample_type(name),

    constraint material_foreign_key
    foreign key (material) references material(name),

    constraint fraction_foreign_key
    foreign key (fraction) references fraction(name)

) engine=innodb;
