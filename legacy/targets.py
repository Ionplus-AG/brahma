#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

sampletype_t = '''
create view _legacy_.sampletype_t as
select
    name as type,
    sort_order as indexnr,
    f14c,
    f14c_sigma as f14c_sig,
    d13c,
    d13c_sigma as d13c_sig,
    d13c_nominal as d13c_nom,
    blank,
    active
from _brahma_.sample_type;
'''

target_v = '''
create view _legacy_.target_v as
select
  target.sample_number as sample_nr,
  target.preparation_number as prep_nr,
  target.number as target_nr,
  concat(target.sample_number, '.', target.preparation_number, '.', target.number) as sample_id,
  concat(target.sample_number, '.', target.preparation_number, '.', target.number) as target_id,
  magazine.name as magazine,
  target.magazine_position as position,
  null as precis,
  null as cycle_min,
  target.cycle_max,
  null as combustion,
  null as catalyst,
  null as cathode_nr,
  target.reactor_number as reactor_nr,
  target.co2_init,
  target.co2_final,
  target.hydro_init,
  target.hydro_final,
  target.react_time,
  target.comment as target_comment,
  target.pressed as target_pressed,
  target.stop,
  target.old_info,
  target.measurement_comment as meas_comment,
  target.fm,
  target.fm_sigma as fm_sig,
  target.dc13,
  target.dc13_sigma as dc13_sig,
  target.calcset,
  target.edit_allowed as editallowed,
  target.c14_age,
  target.c14_age_sigma as c14_age_sig,
  target.cal1s_min as cal1smin,
  target.cal1s_max as cal1smax,
  target.cal2s_min as cal2smin,
  target.cal2s_max as cal2smax,
  target.weight,
  target.conc_n,
  target.graphitized,
  target.temperature as temp,
  target.conc_c,
  preparation.batch,
  sample.type,
  sample.material,
  sample.fraction,
  sample.sampling_date,
  sample.not_to_be_dated as not_tobedated,
  sample.user_label,
  sample.user_label_number as user_label_nr,
  sample.user_description1 as user_desc1,
  sample.user_description2 as user_desc2,
  project.number,
  project.name as project,
  project.advisor,
  project.priority,
  project.status,
  customer.number as user_nr,
  customer.first_name,
  customer.last_name

from _brahma_.target
inner join _brahma_.preparation
  on target.isotope_number = preparation.isotope_number
  and target.sample_number = preparation.sample_number
  and target.preparation_number = preparation.number

inner join _brahma_.sample
  on target.isotope_number = sample.isotope_number
  and target.sample_number = sample.number

inner join _brahma_.project on sample.project_number = project.number
inner join _brahma_.customer on project.customer_number = customer.number
inner join _brahma_.magazine on target.magazine_id = magazine.id

where target.isotope_number = %(isotope_number)s;
'''
