#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

insert_magazine = '''
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

disable_target_triggers = 'set @target_triggers_disabled = true;'
enable_target_triggers = 'set @target_triggers_disabled = null;'
