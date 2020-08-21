#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table preparation (
    number int not null,
    sample_number int not null,
    isotope_number int not null,

    batch varchar(40) default null,
    comment text,
    weight_start double default null,
    weight_medium double default null,
    weight_end double default null,

    step1_method varchar(20) default null, # TODO, ewc 2020-08-21: The right way would be a step table
    step1_start datetime default null,
    step1_end datetime default null,

    step2_method varchar(20) default null,
    step2_start datetime default null,
    step2_end datetime default null,

    step3_method varchar(20) default null,
    step3_start datetime default null,
    step3_end datetime default null,

    step4_method varchar(20) default null,
    step4_start datetime default null,
    step4_end datetime default null,

    cn_ratio double default null,
    c_percent double default null,
    n_percent double default null,
    end date default null,
    stop bool not null default false,
    old_info varchar(8) default null, # TODO, ewc 2020-08-21: what is stored in this field?

    primary key (isotope_number, sample_number, number),

    constraint preparation_sample_foreign_key
    foreign key (isotope_number, sample_number) references sample(isotope_number, number),

    constraint preparation_isotope_foreign_key
    foreign key (isotope_number) references isotope(number),

    constraint preparation_step1_method_foreign_key
    foreign key (step1_method) references preparation_method(name),
    constraint preparation_step2_method_foreign_key
    foreign key (step2_method) references preparation_method(name),
    constraint preparation_step3_method_foreign_key
    foreign key (step3_method) references preparation_method(name),
    constraint preparation_step4_method_foreign_key
    foreign key (step4_method) references preparation_method(name)
) engine=innodb;
