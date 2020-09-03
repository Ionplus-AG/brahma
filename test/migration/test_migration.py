#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

import migration


def test_migrate(db_session, ams_schema, brahma_schema):
    session = migration.Session(db_session, brahma_schema, *ams_schema)

    isotope_number = 3
    assert session.migrate_customer() == 1
    assert session.migrate_project() == 1

    assert session.migrate_sample(isotope_number) == 24
    assert session.migrate_preparation(isotope_number) == 277
    assert session.migrate_target(isotope_number) == 6

    assert session.migrate_magazine() == 2
    assert session.associate_magazine() == 5
    assert session.migrate_measurement_sequence() == 5
