#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import pytest
from sqlalchemy.exc import DatabaseError


def test_updating_is_not_allowed(orm, seed_data):
    with pytest.raises(DatabaseError):
        seed_data.cycle_definition.sequence = 42
        orm.commit()

    orm.rollback()
