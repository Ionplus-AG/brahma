#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

class TableMapping(object):
    def __init__(self, source, target, column_mappings=[]):
        self.source = source
        self.target = target
        self.column_mappings = column_mappings

    def to_query(self, source_schema, target_schema):
        return f'insert into {target_schema}.{self.target}{self.__target_columns()}\n'\
               + f'select {self.__source_columns()}\n'\
               + f'from {source_schema}.{self.source};'

    def __target_columns(self):
        if not self.column_mappings:
            return ''

        target_columns = ', '.join(m[1] for m in self.column_mappings)
        return f' ({target_columns})'

    def __source_columns(self):
        if not self.column_mappings:
            return '*'

        return ', '.join(m[0] for m in self.column_mappings)


customer_mapping = TableMapping('user_t', 'customer')
project_mapping = TableMapping('project_t', 'project')


class Session(object):
    def __init__(self, db_session, target_schema, source_ams_schema, source_ac14_schema):
        self.db_session = db_session
        self.target_schema = target_schema
        self.source_ams_schema = source_ams_schema
        self.source_ac14_schema = source_ac14_schema

    def migrate_customer(self):
        return self.__execute(customer_mapping.to_query(self.source_ams_schema, self.target_schema))

    def migrate_project(self):
        return self.__execute(project_mapping.to_query(self.source_ams_schema, self.target_schema))

    def __execute(self, query):
        with self.db_session.cursor() as cursor:
            cursor.execute(query)
            self.db_session.commit()
            return cursor.rowcount
