#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
from migration import mappings


class Session(object):
    def __init__(self, db_session, target_schema, source_ams_schema, source_ac14_schema):
        self.db_session = db_session
        self.target_schema = target_schema
        self.source_ams_schema = source_ams_schema
        self.source_ac14_schema = source_ac14_schema

    def migrate_customer(self):
        return self.__execute(mappings.customer)

    def migrate_project(self):
        return self.__execute(mappings.project)

    def migrate_sample(self, isotope_number):
        return self.__execute(mappings.sample, (
            (str(isotope_number), 'isotope_number'),
        ))

    def __execute(self, mapping, additional_mappings=()):
        query = mapping.to_query(self.source_ams_schema, self.target_schema, additional_mappings)
        with self.db_session.cursor() as cursor:
            cursor.execute(query)
            self.db_session.commit()
            return cursor.rowcount
