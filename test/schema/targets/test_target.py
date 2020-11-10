#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import datetime

MAGAZINE_INIT_DATE = datetime.datetime.fromisoformat('2000-01-01 08:15')


def test_insert_updates_magazine_last_changed(orm, seed_data):
    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    seed_data.add_target(
        number=31415,
        magazine_id=seed_data.magazine.id
    )

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE


def test_update_updates_magazine_last_changed(orm, seed_data):
    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    seed_data.target.magazine_id = seed_data.magazine.id
    orm.commit()

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE


def test_delete_updates_magazine_last_changed(orm, seed_data):
    target = orm.add(orm.target(
        isotope_number=seed_data.preparation.isotope_number,
        sample_number=seed_data.preparation.sample_number,
        preparation_number=seed_data.preparation.number,
        number=31415,
        magazine_id=seed_data.magazine.id,
    ))
    orm.commit()

    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    orm.delete(target)
    orm.commit()

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE


def test_label(seed_data):
    assert seed_data.target.label == '3.42.4711.1'
