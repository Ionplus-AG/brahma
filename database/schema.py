#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

def exists(schema_name, session):
    query = f"select schema_name from information_schema.schemata where schema_name = '{schema_name}'"
    with session.cursor() as cursor:
        cursor.execute(query)
        return bool(cursor.fetchall())


def drop(schema_name, session):
    query = f'drop database {schema_name}'
    _execute(session, query)


def create(schema_name, session):
    query = f'create database {schema_name} character set utf8mb4 collate utf8mb4_unicode_ci'
    _execute(session, query)


def _execute(session, query, *args):
    with session.cursor() as cursor:
        cursor.execute(query, *args)
        session.commit()
