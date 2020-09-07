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
