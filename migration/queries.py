#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

migrate_magazine = '''
insert into _brahma_.magazine (name, is_gas)
select distinct _ams_.target_t.magazine, false
from _ams_.target_t
where _ams_.target_t.magazine is not null;
'''

# noinspection SqlWithoutWhere
update_target_set_magazine = '''
update _brahma_.target

inner join _ams_.target_t
    on _brahma_.target.sample_number = _ams_.target_t.sample_nr
    and _brahma_.target.preparation_number = _ams_.target_t.prep_nr
    and _brahma_.target.number = _ams_.target_t.target_nr

inner join _brahma_.magazine
    on _ams_.target_t.magazine = _brahma_.magazine.name

set magazine_id = magazine.id;
'''

migrate_measurement_sequence = '''
insert into _brahma_.measurement_sequence (magazine_id, sequence, target_id)
select
    _brahma_.magazine.id,
    _ams_.measprog_t.sequence,
    _brahma_.target.id

from _ams_.measprog_t

inner join _brahma_.magazine
  on _brahma_.magazine.name = _ams_.measprog_t.magazine

inner join _brahma_.target
  on _brahma_.target.magazine_id = _brahma_.magazine.id
  and _brahma_.target.magazine_position = _ams_.measprog_t.position
'''

disable_target_triggers = 'set @target_triggers_disabled = true;'
enable_target_triggers = 'set @target_triggers_disabled = null;'

disable_measurement_sequence_triggers = 'set @measurement_sequence_triggers_disabled = true;'
enable_measurement_sequence_triggers = 'set @measurement_sequence_triggers_disabled = null;'

add_machine = '''
insert into _brahma_.machine (number, name, prefix)
value (%s, %s, %s);
'''

add_cycle_definition = '''
insert into _brahma_.cycle_definition (
    isotope_number,
    machine_number,
    sequence,
    electrical_charge,
    name,
    r_name,
    g1_name,
    g2_name,
    ana_name,
    a_name,
    b_name,
    c_name)
value (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
'''
