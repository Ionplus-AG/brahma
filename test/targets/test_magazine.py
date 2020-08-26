#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

import datetime
import pytest
from sqlalchemy.exc import IntegrityError


@pytest.fixture(autouse=True)
def tear_down(orm):
    yield
    orm.rollback()
    orm.query(orm.magazine).delete()
    orm.commit()


def test_timestamp_is_set(orm):
    magazine = orm.magazine(name='Test01')
    orm.add(magazine)
    orm.commit()

    now = datetime.datetime.utcnow()
    delta = abs(magazine.last_changed - now)
    assert delta.total_seconds() < 5 * 60


def test_name_is_unique(orm):
    orm.add(orm.magazine(name='Test02'))
    orm.commit()

    with pytest.raises(IntegrityError):
        orm.add(orm.magazine(name='Test02'))
        orm.commit()
