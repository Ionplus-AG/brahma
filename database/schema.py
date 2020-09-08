#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

def exists(schema_name, session):
    query = f"select schema_name from information_schema.schemata where schema_name = '{schema_name}'"
    with session.cursor() as cursor:
        cursor.execute(query)
        return bool(cursor.fetchall())
