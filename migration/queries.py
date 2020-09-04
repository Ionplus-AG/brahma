#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

migrate_project_advisor = '''
insert into _brahma_.project_advisor (name, sort_order)
select
     advisor,
     indexnr
from _ams_.advisor_t
on duplicate key update
    name = _ams_.advisor_t.advisor,
    sort_order = _ams_.advisor_t.indexnr
'''

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

migrate_run = '''
insert into _brahma_.run (id, target_id, number, machine_number, comment)
select
  cast(regexp_replace(_ac14_.workproto.run, '[^0-9]', '') as signed) + 1000000 * %s as id,
  _brahma_.target.id,
  row_number() over (
    partition by _brahma_.target.designator order by _ac14_.workproto.run
  ) as number,
  %s as machine_number,
  _ac14_.workproto.meas_comment as comment

from _ac14_.workproto

inner join _brahma_.target
  on _ac14_.workproto.sample_nr = _brahma_.target.sample_number
  and _ac14_.workproto.prep_nr = _brahma_.target.preparation_number
  and _ac14_.workproto.target_nr = _brahma_.target.number

where _brahma_.target.isotope_number = %s

order by _ac14_.workproto.run
'''

migrate_cycle = '''
insert into _brahma_.cycle (run_id, number, cycle_definition_id, runtime, end_of_cycle, enabled,
                            r, g1, g2, ana, a, b, c)
select
  cast(regexp_replace(_ac14_.workana.run, '[^0-9]', '') as signed) + 1000000 * %s as run_id,
  _ac14_.workana.cycle as number,
  %s as cycle_definition_id,
  _ac14_.workana.runtime,
  _ac14_.workana.timedat as end_of_cycle,
  _ac14_.workana.cycltrue is null as enabled,
  _ac14_.workana.r,
  _ac14_.workana.g1,
  _ac14_.workana.g2,
  _ac14_.workana.ana,
  _ac14_.workana.a,
  _ac14_.workana.b,
  _ac14_.workana.iso as c

from _ac14_.workana
where _ac14_.workana.timedat is not null
'''
