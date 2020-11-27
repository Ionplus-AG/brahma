#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import datetime

import pytest

MAGAZINE_INIT_DATE = datetime.datetime.fromisoformat('2000-01-01 08:15')


@pytest.fixture(autouse=True)
def set_up(orm, seed_data):
    seed_data.target.magazine_id = seed_data.magazine.id
    orm.commit()

    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()


def test_insert_updates_magazine_last_changed(orm, seed_data):
    seed_data.add(orm.measurement_sequence(
        magazine_id=seed_data.magazine.id,
        sequence=1,
        position=14,
    ))
    orm.commit()

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE


def test_update_updates_magazine_last_changed(orm, seed_data):
    measurement_sequence = seed_data.add(orm.measurement_sequence(
        magazine_id=seed_data.magazine.id,
        sequence=1,
        position=14,
    ))
    orm.commit()

    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    measurement_sequence.sequence = 2
    orm.commit()

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE


def test_delete_updates_magazine_last_changed(orm, seed_data):
    measurement_sequence = orm.add(orm.measurement_sequence(
        magazine_id=seed_data.magazine.id,
        sequence=1,
        position=14,
    ))
    orm.commit()

    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    orm.delete(measurement_sequence)
    orm.commit()

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE
