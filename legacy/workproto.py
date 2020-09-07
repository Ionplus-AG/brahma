#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

workproto_v_nt = '''
create view _legacy_.workproto_v_nt as
select
  run.id as recno,
  concat(machine.prefix, run.id) as run,
  target.sample_number as sample_nr,
  target.preparation_number as prep_nr,
  target.number as target_nr,
  concat(target.sample_number, '.', target.preparation_number, '.', target.number) as sample_id,
  concat(target.sample_number, '.', target.preparation_number, '.', target.number) as target_id,
  run.end_of_last_cycle as timedat,
  run.runtime,
  run.enabled_cycles as cycles,
  run.r,
  run.r_delta as rdel,
  run.g1,
  run.g1_delta as g1del,
  run.g2,
  run.g2_delta as g2del,
  run.a,
  run.b,
  run.ana,
  null as anb,
  run.c as iso,
  run.ratio_r_a as ra,
  run.ratio_r_a_delta as radel,
  run.ratio_r_a_sigma as rasig,
  run.ratio_b_a * 100 as ba,
  run.ratio_b_a_delta as badel,
  run.ratio_b_a_sigma as basig,
  run.ratio_r_b as rb,
  run.ratio_r_b_delta as rbdel,
  run.ratio_r_b_sigma as rbsig,
  null as g1a,
  null as g1b,
  null as g2a,
  null as g2b,
  null as anbana,
  null as anbandel,
  null as anbansig,
  run.transmission as tra,
  run.transmission_sigma as trasig,
  null as age,
  null as agedel,
  if(run.enabled, null, '*') as ratrue,
  null as batrue,
  run.comment as meas_comment_p,
  magazine.name as magazine,
  target.magazine_position as position,
  target.edit_allowed as editallowed,
  target.co2_init,
  target.co2_final,
  target.measurement_comment as meas_comment_t,
  sample.type,
  sample.material,
  sample.fraction,
  sample.user_label,
  sample.user_label_number as user_label_nr,
  sample.user_description1 as user_desc1,
  sample.user_description2 as user_desc2
from _brahma_.run
inner join _brahma_.machine on run.machine_number = machine.number
inner join _brahma_.target on run.target_id = target.id
inner join _brahma_.sample on target.sample_number = sample.number
inner join _brahma_.magazine on target.magazine_id = magazine.id

where _brahma_.run.machine_number = _machine_
  and _brahma_.target.isotope_number = _isotope_;
'''
