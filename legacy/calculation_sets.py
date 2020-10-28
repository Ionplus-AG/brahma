#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

calc_corr_t = '''
create view _legacy_.calc_corr_t as
select *
from _brahma_.calculation_correction;
'''

calc_sample_t = '''
create view _legacy_.calc_sample_t as
select
    calcset,
    isotope_number as isotope_nr,
    sample_number as sample_nr,
    preparation_number as prep_nr,
    target_number as target_nr,
    type,
    prep_bl,
    active,
    std_bl

from _brahma_.calculation_sample
where isotope_number = %(isotope_number)s;
'''

calc_set_t = '''
create view _legacy_.calc_set_t as
select *
from _brahma_.calculation_set;
'''
