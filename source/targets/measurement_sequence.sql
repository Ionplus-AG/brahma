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
)
