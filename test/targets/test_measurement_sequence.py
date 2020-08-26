#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import datetime
import pytest

TARGET_ID = 4711
MAGAZINE_ID = 42
MAGAZINE_INIT_DATE = datetime.datetime.fromisoformat('2000-01-01 08:15')


@pytest.fixture(autouse=True)
def set_up(db_cursor, db_connection):
    db_cursor.execute(
        "insert into magazine (id, name, last_changed) values (%s, 'test_mag', %s)",
        (MAGAZINE_ID, MAGAZINE_INIT_DATE))
    db_connection.commit()


@pytest.fixture(autouse=True)
def tear_down(db_cursor, db_connection):
    yield
    db_cursor.execute('delete from target where id = %s', (TARGET_ID,))
    db_cursor.execute('delete from magazine where id = %s', (MAGAZINE_ID,))
    db_connection.commit()
