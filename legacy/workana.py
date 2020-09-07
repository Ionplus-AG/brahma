#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

# TODO, ewc, 2020-09-07: deba -> dba?
workana_v = '''
create view _legacy_.workana_v as
select
  cycle.ratio_r_a * 1e12 as ra12,
  cycle.ratio_r_b * 1e12 as rb12,
  cycle.r - (run.r / run.enabled_cycles) as dr,
  ((cycle.ratio_r_a - run.ratio_r_a) / run.ratio_r_a) * 100 as dra,
  ((cycle.ratio_b_a - run.ratio_b_a) / run.ratio_b_a) * 100 as deba,
  ((cycle.ratio_r_b - run.ratio_r_b) / run.ratio_r_b) * 100 as drb,
  ((cycle.transmission - run.transmission) / run.transmission) * 100 as dtra,
  cycle.id as recno,
  concat(machine.prefix, run.id) as run,
  cycle.number as cycle,
  cycle.runtime,
  cycle.end_of_cycle as timedat,
  cycle.r,
  cycle.g1,
  cycle.g2,
  cycle.a,
  cycle.b,
  cycle.ana,
  null as anb,
  cycle.c as iso,
  cycle.ratio_r_a as ra,
  cycle.ratio_b_a * 100 as ba,
  cycle.ratio_r_b as rb,
  null as g1a,
  null as g1b,
  null as g2a,
  null as g2b,
  null as anbana,
  cycle.transmission as tra,
  null as sca1,
  null as sca2,
  null as sca3,
  null as sca4,
  null as sca5,
  null as sca6,
  null as sca7,
  null as sca8,
  null as sca9,
  null as sca10,
  null as sca11,
  null as sca12,
  null as sca13,
  null as sca14,
  null as sca15,
  if(cycle.enabled, null, '*') as cycltrue,
  null as age,
  null as agedel,
  null as scandev1,
  null as scandac1,
  null as scanadc1,
  null as scandev2,
  null as scandac2,
  null as scanadc2,
  null as strippr
from _brahma_.cycle
inner join _brahma_.run on cycle.run_id = run.id
inner join _brahma_.machine on run.machine_number = machine.number
inner join _brahma_.cycle_definition on cycle.cycle_definition_id = cycle_definition.id

where run.machine_number = _machine_
  and cycle_definition.isotope_number = _isotope_;
'''
