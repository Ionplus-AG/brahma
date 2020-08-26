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
def set_up(orm):
    orm.add(orm.magazine(id=MAGAZINE_ID, name='test_mag', last_changed=MAGAZINE_INIT_DATE))
    orm.commit()


@pytest.fixture(autouse=True)
def tear_down(orm):
    yield
    orm.query(orm.target).filter(orm.target.id == TARGET_ID).delete()
    orm.query(orm.magazine).filter(orm.magazine.id == MAGAZINE_ID).delete()
    orm.commit()


def get_magazine_last_changed(orm):
    return orm.query(orm.magazine).filter(orm.magazine.id == MAGAZINE_ID).one().last_changed


def test_insert_updates_magazine_last_changed(orm):
    orm.add(orm.target(
        id=TARGET_ID,
        isotope_number=3,
        sample_number=101,
        preparation_number=1001,
        number=TARGET_ID,
        magazine_id=MAGAZINE_ID
    ))
    orm.commit()

    assert get_magazine_last_changed(orm) > MAGAZINE_INIT_DATE


def test_update_updates_magazine_last_changed(orm):
    target = orm.target(
        id=TARGET_ID,
        isotope_number=3,
        sample_number=101,
        preparation_number=1001,
        number=TARGET_ID)
    orm.add(target)
    orm.commit()

    assert get_magazine_last_changed(orm) == MAGAZINE_INIT_DATE

    target.magazine_id = MAGAZINE_ID
    orm.commit()

    assert get_magazine_last_changed(orm) > MAGAZINE_INIT_DATE


def test_delete_updates_magazine_last_changed(orm):
    target = orm.target(
        id=TARGET_ID,
        isotope_number=3,
        sample_number=101,
        preparation_number=1001,
        number=TARGET_ID,
        magazine_id=MAGAZINE_ID)
    orm.add(target)
    orm.commit()

    magazine = orm.query(orm.magazine).filter(orm.magazine.id == MAGAZINE_ID).one()
    magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    assert get_magazine_last_changed(orm) == MAGAZINE_INIT_DATE

    orm.delete(target)
    orm.commit()

    assert get_magazine_last_changed(orm) > MAGAZINE_INIT_DATE
