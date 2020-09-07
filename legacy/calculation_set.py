#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

calc_set_t = '''
create view _legacy_.calc_set_t as
select *
from _brahma_.calculation_set;
'''
