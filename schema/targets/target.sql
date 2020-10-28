#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table target (
    id int primary key auto_increment,

    isotope_number int not null,
    sample_number int not null,
    preparation_number int not null,
    number int not null,
    designator tinytext generated always as (concat(
        isotope_number, '.',
        sample_number, '.',
        preparation_number, '.',
        number)) virtual,

    magazine_id int default null,
    magazine_position int default null,

    cycle_max int default null,

    reactor_number smallint(6) default '0',
    co2_init double default null,
    co2_final double default null,
    hydro_init smallint(3) default null,
    hydro_final smallint(3) default null,
    react_time smallint(3) default null,
    comment text,
    pressed date default null,
    stop tinyint(1) default '0', # TODO, 2020-09-02, ewc: could this be a bool?
    old_info varchar(8) default null,
    measurement_comment varchar(80) default null,
    fm double default null,
    fm_sigma double default null,
    dc13 double default null,
    dc13_sigma double default null,
    calcset varchar(20) default null,
    edit_allowed bool default true,
    c14_age double default null,
    c14_age_sigma double default null,
    cal1s_min int(4) default null,
    cal1s_max int(4) default null,
    cal2s_min int(4) default null,
    cal2s_max int(4) default null,
    weight double default null,
    graphitized date default null,
    temperature double default null,
    conc_c double default null,
    conc_n double default null,

    carrier double default null,

    active_runs int not null default 0,
    total_runs int not null default 0,

    runtime double not null default 0, # time in seconds

    r int default null,
    g1 int default null,
    g2 int default null,

    ana double default null, # current in µA
    a double default null, # current in µA
    b double default null, # current in µA
    c double default null, # current in µA

    ratio_r_a double default null,
    ratio_r_a_sigma double default null,

    ratio_r_b double default null,
    ratio_r_b_sigma double default null,

    ratio_g1_a double default null,
    ratio_g1_b double default null,
    ratio_g2_a double default null,
    ratio_g2_b double default null,

    ratio_b_a double default null,
    ratio_b_a_sigma double default null,

    transmission double default null, # ratio a/ana in %
    transmission_sigma double default null,

    constraint target_numbers_unique
    unique (isotope_number, sample_number, preparation_number, number),

    constraint target_preparation_foreign_key
    foreign key (isotope_number, sample_number, preparation_number)
    references preparation(isotope_number, sample_number, number),

    constraint target_sample_foreign_key
    foreign key (isotope_number, sample_number) references sample(isotope_number, number),

    constraint target_isotope_foreign_key
    foreign key (isotope_number) references isotope(number),

    constraint target_magazine_foreign_key
    foreign key (magazine_id) references magazine(id)
) engine=innodb;

delimiter //

# summary:
# Triggers updating the associated magazines of the inserted, updated or deleted targets.

set @target_triggers_disabled = false;

create trigger target_insert_updates_magazine_last_changed
after insert on target for each row
main:
begin
    if @target_triggers_disabled then
        leave main;
    end if;

    if new.magazine_id is not null then
        update magazine set last_changed = current_timestamp where id = new.magazine_id;
    end if;
end;

create trigger target_update_updates_magazine_last_changed
after update on target for each row
main:
begin
    if @target_triggers_disabled then
        leave main;
    end if;

    if new.magazine_id is not null then
        update magazine set last_changed = current_timestamp where id = new.magazine_id;
    end if;
    if old.magazine_id is not null and old.magazine_id <> new.magazine_id then
        update magazine set last_changed = current_timestamp where id = old.magazine_id;
    end if;
end;

create trigger target_delete_updates_magazine_last_changed
after delete on target for each row
main:
begin
    if @target_triggers_disabled then
        leave main;
    end if;

    if ( old.magazine_id is not null ) then
        update magazine set last_changed = current_timestamp where id = old.magazine_id;
    end if;
end;

//
delimiter ;
