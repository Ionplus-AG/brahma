#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

import datetime
import mysql.connector
import pytest


def test_timestamp_is_set(db_cursor, db_connection):
    db_cursor.execute("insert into magazine (name) values ('Test01')")
    db_connection.commit()

    now = datetime.datetime.utcnow()

    db_cursor.execute('select last_changed from magazine')
    last_changed = db_cursor.fetchall()[0][0]

    delta = abs(last_changed - now)
    assert delta.total_seconds() < 5 * 60


def test_name_is_unique(db_cursor, db_connection):
    db_cursor.execute("insert into magazine (name) values ('Test02')")
    db_connection.commit()

    with pytest.raises(mysql.connector.IntegrityError):
        db_cursor.execute("insert into magazine (name) values ('Test02')")
        db_connection.commit()
