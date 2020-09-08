#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import pathlib

from database import schema
from database import sql_script

_schema_sql = pathlib.Path(__file__).parent.parent.absolute() / 'schema' / 'brahma.sql'


class Brahma(object):
    def __init__(self, schema_name, session):
        self.schema_name = schema_name
        self.session = session

    @property
    def exists(self):
        return schema.exists(self.schema_name, self.session)

    def create(self):
        schema.create(self.schema_name, self.session)

        # noinspection PyProtectedMember
        sql_script.run(_schema_sql, self.session._host, self.session._user, self.session._password, self.schema_name)

    def drop(self):
        schema.drop(self.schema_name, self.session)
