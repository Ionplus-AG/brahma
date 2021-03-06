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

set magazine_id = _brahma_.magazine.id;
'''

migrate_measurement_sequence = '''
insert into _brahma_.measurement_sequence (magazine_id, sequence, position)
select
    _brahma_.magazine.id,
    _ams_.measprog_t.sequence,
    _ams_.measprog_t.position

from _ams_.measprog_t

inner join _brahma_.magazine
  on _brahma_.magazine.name = _ams_.measprog_t.magazine
'''

disable_target_triggers = 'set @target_triggers_disabled = true;'
enable_target_triggers = 'set @target_triggers_disabled = null;'

disable_measurement_sequence_triggers = 'set @measurement_sequence_triggers_disabled = true;'
enable_measurement_sequence_triggers = 'set @measurement_sequence_triggers_disabled = null;'

add_machine = '''
insert into _brahma_.machine (number, name, prefix)
value (%(number)s, %(name)s, %(prefix)s);
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
value (
    %(isotope_number)s,
    %(machine_number)s,
    %(sequence)s,
    %(electrical_charge)s,
    %(name)s,
    %(r_name)s,
    %(g1_name)s,
    %(g2_name)s,
    %(ana_name)s,
    %(a_name)s,
    %(b_name)s,
    %(c_name)s);
'''

migrate_run = '''
insert into _brahma_.run (id, target_id, target_run_number, machine_number, machine_run_number, comment)
select
  sub.machine_run_number + (1000000 * %(machine_number)s) as id,
  sub.target_id,
  sub.target_run_number,
  %(machine_number)s as machine_number,
  sub.machine_run_number,
  sub.comment

from (
  select
    _brahma_.target.id as target_id,

    row_number() over (
        partition by _brahma_.target.label order by _ac14_.workproto.run
    ) as target_run_number,

    cast(trim(leading _brahma_.machine.prefix from _ac14_.workproto.run) as signed) as machine_run_number,

    _ac14_.workproto.meas_comment as comment

  from _ac14_.workproto

  inner join _brahma_.target
    on _ac14_.workproto.sample_nr = _brahma_.target.sample_number
    and _ac14_.workproto.prep_nr = _brahma_.target.preparation_number
    and _ac14_.workproto.target_nr = _brahma_.target.number

  join _brahma_.machine on _brahma_.machine.number = %(machine_number)s

  where _brahma_.target.isotope_number = %(isotope_number)s
    and _ac14_.workproto.run like concat(_brahma_.machine.prefix, '%')

  order by _ac14_.workproto.run
) as sub
'''

migrate_cycle = '''
insert into _brahma_.cycle (run_id, number, cycle_definition_id, runtime, end_of_cycle, enabled,
                            r, g1, g2, ana, a, b, c)
select
  cast(trim(leading _brahma_.machine.prefix from _ac14_.workana.run) as signed) +
    (1000000 * %(machine_number)s) as run_id,

  _ac14_.workana.cycle as number,
  %(cycle_definition_id)s as cycle_definition_id,
  _ac14_.workana.runtime,
  _ac14_.workana.timedat as end_of_cycle,
  _ac14_.workana.cycltrue is null as enabled,
  if(_ac14_.workana.r >= 0, _ac14_.workana.r, null),
  if(_ac14_.workana.g1 >= 0, _ac14_.workana.g1, null),
  if(_ac14_.workana.g2 >= 0, _ac14_.workana.g2, null),
  if(_ac14_.workana.ana >= 0, _ac14_.workana.ana, null),
  if(_ac14_.workana.a >= 0, _ac14_.workana.a, null),
  if(_ac14_.workana.b >= 0, _ac14_.workana.b, null),
  if(_ac14_.workana.iso >= 0, _ac14_.workana.iso, null) as c

from _ac14_.workana

inner join _ac14_.workproto on _ac14_.workana.RUN = _ac14_.workproto.RUN

inner join _brahma_.target
  on _ac14_.workproto.sample_nr = _brahma_.target.sample_number
  and _ac14_.workproto.prep_nr = _brahma_.target.preparation_number
  and _ac14_.workproto.target_nr = _brahma_.target.number

join _brahma_.machine on _brahma_.machine.number = %(machine_number)s

where _brahma_.target.isotope_number = %(isotope_number)s
  and _ac14_.workana.run like concat(_brahma_.machine.prefix, '%')
'''
