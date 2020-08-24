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


def get_magazine_last_changed(db_cursor):
    db_cursor.execute('select last_changed from magazine where id = %s', (MAGAZINE_ID,))
    return db_cursor.fetchall()[0][0]


def test_insert_updates_magazine_last_changed(db_cursor, db_connection):
    db_cursor.execute(
        """
        insert into target (id, isotope_number, sample_number, preparation_number, number, magazine_id)
        values (%s, 3, 101, 1001, %s, %s)
        """,
        (TARGET_ID, TARGET_ID, MAGAZINE_ID))
    db_connection.commit()

    assert get_magazine_last_changed(db_cursor) > MAGAZINE_INIT_DATE


def test_update_updates_magazine_last_changed(db_cursor, db_connection):
    db_cursor.execute(
        f"""
        insert into target (id, isotope_number, sample_number, preparation_number, number)
        values (%s, 3, 101, 1001, %s)
        """,
        (TARGET_ID, TARGET_ID))
    db_connection.commit()

    db_cursor.execute('update target set magazine_id = %s where id = %s',
                      (MAGAZINE_ID, TARGET_ID))
    db_connection.commit()

    assert get_magazine_last_changed(db_cursor) > MAGAZINE_INIT_DATE


def test_delete_updates_magazine_last_changed(db_cursor, db_connection):
    db_cursor.execute(
        """
        insert into target (id, isotope_number, sample_number, preparation_number, number, magazine_id)
        values (%s, 3, 101, 1001, %s, %s)
        """,
        (TARGET_ID, TARGET_ID, MAGAZINE_ID))
    db_connection.commit()

    db_cursor.execute('update magazine set last_changed = %s where id = %s',
                      (MAGAZINE_INIT_DATE, MAGAZINE_ID))
    db_connection.commit()

    db_cursor.execute('delete from target where id = %s', (TARGET_ID,))

    assert get_magazine_last_changed(db_cursor) > MAGAZINE_INIT_DATE


def test_insert_without_magazine_doesnt_throw(db_cursor, db_connection):
    pass


def test_update_without_magazine_doesnt_throw(db_cursor, db_connection):
    pass


def test_delete_without_magazine_doesnt_throw(db_cursor, db_connection):
    pass
