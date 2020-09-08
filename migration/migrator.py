#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

class Migrator(object):
    def __init__(self, db_session, source_schema_template, source_schema, target_schema):
        self.db_session = db_session
        self.source_schema = source_schema
        self.target_schema = target_schema
        self.schema_mappings = [
            ('_brahma_', target_schema),
            (source_schema_template, source_schema),
        ]

    def _call_for_each(self, query, call):
        with self.db_session.cursor() as cursor:
            cursor.execute(self._prepare(query))
            result = cursor.fetchall()
            for row in result:
                cursor.execute(self._prepare(call.format(*row)))

            self.db_session.commit()
            return len(result)

    def _map(self, mapping, additional_mappings=()):
        query = mapping.to_query(self.source_schema, self.target_schema, additional_mappings)
        return self._execute(query)

    def _prepare(self, query):
        for schema_mapping in self.schema_mappings:
            query = query.replace(*schema_mapping)

        return query

    def _execute(self, query, *args):
        with self.db_session.cursor() as cursor:
            cursor.execute(query, args)
            self.db_session.commit()
            return cursor.rowcount

    def _get_last_insert_id(self):
        query = 'select last_insert_id();'
        with self.db_session.cursor() as cursor:
            cursor.execute(query)
            return cursor.fetchall()[0][0]
