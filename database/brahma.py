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
        query = f'create database {self.schema_name} character set utf8mb4 collate utf8mb4_unicode_ci'
        self.__execute(query)

        # noinspection PyProtectedMember
        sql_script.run(_schema_sql, self.session._host, self.session._user, self.session._password, self.schema_name)

    def drop(self):
        query = f'drop database {self.schema_name}'
        self.__execute(query)

    def __execute(self, query, *args):
        with self.session.cursor() as cursor:
            cursor.execute(query, *args)
            self.session.commit()
