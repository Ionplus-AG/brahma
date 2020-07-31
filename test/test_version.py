#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

def test_schema_version_is_set(db_cursor):
    db_cursor.execute('select max(version) from schema_change')
    assert db_cursor.fetchall() == [(1,)]
