#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import itertools

from validation import rules


class Rule(object):
    def __init__(self, query, template):
        self.query = query
        self.template = template

    def format_error(self, result):
        return self.template.format(*result)


class Validator(object):
    def __init__(self, db_session, ams_schema, ac14_schema):
        self.db_session = db_session
        self.ams_schema = ams_schema
        self.ac14_schema = ac14_schema
        self.schema_mappings = [
            ('_ams_', ams_schema),
            ('_ac14_', ac14_schema),
        ]

    def run(self):
        return itertools.chain.from_iterable(
            (rule.format_error(r) for r in self._execute(rule.query))
            for rule in rules.tutti)

    def _prepare(self, query):
        for schema_mapping in self.schema_mappings:
            query = query.replace(*schema_mapping)

        return query

    def _execute(self, query, **kwargs):
        with self.db_session.cursor() as cursor:
            cursor.execute(self._prepare(query), kwargs)
            return cursor.fetchall()
