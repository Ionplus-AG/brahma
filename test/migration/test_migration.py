#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

import migration


def test_migrate(db_session, ams_schema, brahma_schema):
    ams_migrator = migration.AmsMigrator(db_session, ams_schema[0], brahma_schema, 3)
    assert ams_migrator.migrate_customer() == 1
    assert ams_migrator.migrate_project_advisor() == 3
    assert ams_migrator.migrate_project() == 1

    assert ams_migrator.migrate_sample() == 24
    assert ams_migrator.migrate_preparation() == 277
    assert ams_migrator.migrate_target() == 6

    assert ams_migrator.migrate_magazine() == 2
    assert ams_migrator.associate_magazine() == 5
    assert ams_migrator.migrate_measurement_sequence() == 5

    assert ams_migrator.migrate_calculation_set() == 0
    assert ams_migrator.migrate_calculation_correction() == 0
    assert ams_migrator.migrate_calculation_sample() == 0

    # migrate all ACxxxxx runs/cycles
    ac14_migrator = migration.Ac14Migrator(db_session, ams_schema[1], brahma_schema, 3, 42)
    assert ac14_migrator.add_machine('MICADAS.42', 'AC') == ac14_migrator.machine_number
    assert ac14_migrator.migrate_run() == 6

    cycle_definition_id = ac14_migrator.add_default_cycle_definition()
    assert ac14_migrator.migrate_cycle(cycle_definition_id) == 12

    assert ac14_migrator.calculate_runs() == 6
    assert ac14_migrator.calculate_targets() == 2

    # migrate all BCxxxxx runs/cycles
    bc14_migrator = migration.Ac14Migrator(db_session, ams_schema[1], brahma_schema, 3, 43)
    assert bc14_migrator.add_machine('MICADAS.43', 'BC') == bc14_migrator.machine_number
    assert bc14_migrator.migrate_run() == 2

    cycle_definition_id = bc14_migrator.add_default_cycle_definition()
    assert bc14_migrator.migrate_cycle(cycle_definition_id) == 6

    assert bc14_migrator.calculate_runs() == 2
    assert bc14_migrator.calculate_targets() == 1
