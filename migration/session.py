#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
from migration import mapping


def _map_isotope_number(isotope_number):
    return isotope_number, 'isotope_number'


_insert_magazine = '''
insert into _brahma_.magazine (name, is_gas)
select distinct _ams_.target_t.magazine, false
from _ams_.target_t
where _ams_.target_t.magazine is not null;
'''

# noinspection SqlWithoutWhere
_set_magazine = '''
update _brahma_.target
inner join _ams_.target_t
    on _brahma_.target.sample_number = _ams_.target_t.sample_nr
    and _brahma_.target.preparation_number = _ams_.target_t.prep_nr
    and _brahma_.target.number = _ams_.target_t.target_nr
inner join _brahma_.magazine
    on _ams_.target_t.magazine = _brahma_.magazine.name
set magazine_id = magazine.id;
'''

_disable_target_triggers = 'set @target_triggers_disabled = true;'
_enable_target_triggers = 'set @target_triggers_disabled = null;'


class Session(object):
    def __init__(self, db_session, target_schema, source_ams_schema, source_ac14_schema):
        self.db_session = db_session
        self.target_schema = target_schema
        self.source_ams_schema = source_ams_schema
        self.source_ac14_schema = source_ac14_schema

    def migrate_customer(self):
        return self.__map(mapping.customer)

    def migrate_project(self):
        return self.__map(mapping.project)

    def migrate_sample(self, isotope_number):
        return self.__map(mapping.sample, (_map_isotope_number(isotope_number),))

    def migrate_preparation(self, isotope_number):
        return self.__map(mapping.preparation, (_map_isotope_number(isotope_number),))

    def migrate_target(self, isotope_number):
        return self.__map(mapping.target, (_map_isotope_number(isotope_number),))

    def migrate_magazine(self):
        return self.__execute(self.__prepare(_insert_magazine))

    def associate_magazine(self):
        self.__execute(_disable_target_triggers)
        result = self.__execute(self.__prepare(_set_magazine))
        self.__execute(_enable_target_triggers)
        return result

    def __map(self, mapping, additional_mappings=()):
        query = mapping.to_query(self.source_ams_schema, self.target_schema, additional_mappings)
        return self.__execute(query)

    def __prepare(self, query):
        return query\
            .replace('_ams_', self.source_ams_schema)\
            .replace('_ac14_', self.source_ac14_schema)\
            .replace('_brahma_', self.target_schema)

    def __execute(self, query):
        with self.db_session.cursor() as cursor:
            cursor.execute(query)
            self.db_session.commit()
            return cursor.rowcount
