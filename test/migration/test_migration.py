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

    machine_number = 42
    assert session.add_machine(machine_number, 'MICADAS.42', 'M42') == machine_number
    assert session.migrate_run(isotope_number, machine_number) == 6

    cycle_definition_id = session.add_default_cycle_definition(isotope_number, machine_number)
    assert session.migrate_cycle(cycle_definition_id, machine_number) == 12

    assert session.calculate_all_runs() == 6
    assert session.calculate_all_targets() == 6
