#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
from migration import mappings
from migration import queries
from migration.migrator import Migrator


class AmsMigrator(Migrator):
    def __init__(self, db_session, source_schema, target_schema, isotope_number):
        super().__init__(db_session, '_ams_', source_schema, target_schema)
        self.isotope_number = isotope_number

    def migrate_customer(self):
        return self._map(mappings.customer)

    def migrate_project_advisor(self):
        return self._execute(self._prepare(queries.migrate_project_advisor))

    def migrate_project(self):
        return self._map(mappings.project)

    def migrate_project_type(self):
        return self._map(mappings.project_type)

    def migrate_sample_type(self):
        return self._map(mappings.sample_type)

    def migrate_report_type(self):
        return self._map(mappings.report_type)

    def migrate_research_type(self):
        return self._map(mappings.research_type)

    def migrate_material(self):
        return self._map(mappings.material)

    def migrate_fraction(self):
        return self._map(mappings.fraction)

    def migrate_method(self):
        return self._map(mappings.method)

    def project_status(self):
        return self._map(mappings.project_status)

    def migrate_sample(self):
        return self._map(mappings.sample, (mappings.isotope_number(self.isotope_number),))

    def migrate_preparation(self):
        return self._map(mappings.preparation, (mappings.isotope_number(self.isotope_number),))

    def migrate_target(self):
        return self._map(mappings.target, (mappings.isotope_number(self.isotope_number),))

    def migrate_magazine(self):
        return self._execute(self._prepare(queries.migrate_magazine))

    def associate_magazine(self):
        self._execute(queries.disable_target_triggers)
        result = self._execute(self._prepare(queries.update_target_set_magazine))
        self._execute(queries.enable_target_triggers)
        return result

    def migrate_measurement_sequence(self):
        self._execute(queries.disable_measurement_sequence_triggers)
        result = self._execute(self._prepare(queries.migrate_measurement_sequence))
        self._execute(queries.enable_measurement_sequence_triggers)
        return result

    def migrate_calculation_set(self):
        return self._map(mappings.calculation_set)

    def migrate_calculation_correction(self):
        return self._map(mappings.calculation_correction)

    def migrate_calculation_sample(self):
        return self._map(mappings.calculation_sample, (mappings.isotope_number(self.isotope_number),))
