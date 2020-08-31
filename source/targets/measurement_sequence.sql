#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table measurement_sequence (
    id int primary key auto_increment,
    magazine_id int not null,
    sequence int not null, # TODO, ewc 2020-08-24: we decided on 'index' previously, but that's a reserved keyword in SQL
    target_id int not null,

    constraint measurement_sequence_magazine_foreign_key
    foreign key (magazine_id) references magazine(id),

    constraint measurement_sequence_target_foreign_key
    foreign key (target_id) references target(id),

    constraint measurement_sequence_per_magazine_unique
    unique (magazine_id, sequence)
) engine=innodb;

delimiter //

create trigger measurement_sequence_updates_magazine_last_changed
after insert on measurement_sequence for each row
begin
    update magazine set last_changed = current_timestamp where id = new.magazine_id;
end;

create trigger measurement_sequence_update_updates_magazine_last_changed
after update on measurement_sequence for each row
begin
    update magazine set last_changed = current_timestamp where id = new.magazine_id;
    if ( old.magazine_id <> new.magazine_id ) then
        update magazine set last_changed = current_timestamp where id = old.magazine_id;
    end if;
end;

create trigger measurement_sequence_delete_updates_magazine_last_changed
after delete on measurement_sequence for each row
begin
    update magazine set last_changed = current_timestamp where id = old.magazine_id;
end;

//
delimiter ;
