#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

from sqlalchemy import desc


def test_schema_version_is_set(orm):
    last_change = orm.query(orm.schema_change).order_by(desc(orm.schema_change.version)).first()
    assert last_change.version == 1
