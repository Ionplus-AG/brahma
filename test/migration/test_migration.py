#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

import migration


def test_migrate(db_session, ams_schema, brahma_schema):
    session = migration.Session(db_session, brahma_schema, *ams_schema)
    assert session.migrate_customer() == 1
    assert session.migrate_project() == 1
    assert session.migrate_sample(3) == 24
