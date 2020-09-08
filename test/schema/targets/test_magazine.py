#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

import datetime
import pytest
from sqlalchemy.exc import IntegrityError


def test_timestamp_is_set(orm):
    magazine = orm.magazine(name='Test01')
    orm.add(magazine)
    orm.commit()

    now = datetime.datetime.utcnow()
    delta = abs(magazine.last_changed - now)
    assert delta.total_seconds() < 5 * 60

    orm.delete(magazine)
    orm.commit()


def test_name_is_unique(orm):
    magazine = orm.add(orm.magazine(name='Test02'))
    orm.commit()

    with pytest.raises(IntegrityError):
        orm.add(orm.magazine(name='Test02'))
        orm.commit()

    orm.rollback()
    orm.delete(magazine)
    orm.commit()
