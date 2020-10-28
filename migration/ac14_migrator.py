#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
from migration import cycle_definition
from migration import queries
from migration.migrator import Migrator


class Ac14Migrator(Migrator):
    def __init__(self, db_session, source_schema, target_schema, isotope_number, machine_number):
        super().__init__(db_session, '_ac14_', source_schema, target_schema)
        self.isotope_number = isotope_number
        self.machine_number = machine_number

    def add_machine(self, name, prefix):
        self._execute(
            self._prepare(queries.add_machine),
            number=self.machine_number,
            name=name,
            prefix=prefix,
        )
        return self.machine_number

    def add_cycle_definition(self, definition):
        self._execute(
            self._prepare(queries.add_cycle_definition),
            **vars(definition),
        )
        return self._get_last_insert_id()

    def add_default_cycle_definition(self):
        definition = cycle_definition.default[self.isotope_number](self.machine_number)
        return self.add_cycle_definition(definition)

    def migrate_run(self):
        return self._execute(
            self._prepare(queries.migrate_run),
            machine_number=self.machine_number,
            isotope_number=self.isotope_number,
        )

    def migrate_cycle(self, cycle_definition_id):
        return self._execute(
            self._prepare(queries.migrate_cycle),
            machine_number=self.machine_number,
            isotope_number=self.isotope_number,
            cycle_definition_id=cycle_definition_id,
        )

    def calculate_runs(self):
        query = f"select id from _brahma_.run where machine_number = '{self.machine_number}'"
        call = 'call _brahma_.calculate_run({0})'
        return self._call_for_each(query, call)

    def calculate_targets(self):
        query = f"select distinct target_id from _brahma_.run where machine_number = '{self.machine_number}'"
        call = 'call _brahma_.calculate_target({0})'
        return self._call_for_each(query, call)
