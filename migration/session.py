#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
from migration import mappings
from migration import queries


class Session(object):
    def __init__(self, db_session, target_schema, source_ams_schema, source_ac14_schema):
        self.db_session = db_session
        self.target_schema = target_schema
        self.source_ams_schema = source_ams_schema
        self.source_ac14_schema = source_ac14_schema

    def migrate_customer(self):
        return self.__map(mappings.customer)

    def migrate_project(self):
        return self.__map(mappings.project)

    def migrate_sample(self, isotope_number):
        return self.__map(mappings.sample, (mappings.isotope_number(isotope_number),))

    def migrate_preparation(self, isotope_number):
        return self.__map(mappings.preparation, (mappings.isotope_number(isotope_number),))

    def migrate_target(self, isotope_number):
        return self.__map(mappings.target, (mappings.isotope_number(isotope_number),))

    def migrate_magazine(self):
        return self.__execute(self.__prepare(queries.insert_magazine))

    def associate_magazine(self):
        self.__execute(queries.disable_target_triggers)
        result = self.__execute(self.__prepare(queries.update_target_set_magazine))
        self.__execute(queries.enable_target_triggers)
        return result

    def migrate_measurement_sequence(self):
        self.__execute(queries.disable_measurement_sequence_triggers)
        result = self.__execute(self.__prepare(queries.insert_measurement_sequence))
        self.__execute(queries.enable_measurement_sequence_triggers)
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
