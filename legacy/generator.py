#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

from legacy import calculation_sets, routines, targets, results


class Generator(object):
    def __init__(self, db_session, source_schema, target_schema, machine_number, isotope_number):
        self.db_session = db_session
        self.source_schema = source_schema
        self.target_schema = target_schema
        self.machine_number = machine_number
        self.isotope_number = isotope_number

        self.schema_mappings = [
            ('_brahma_', source_schema),
            ('_legacy_', target_schema),
            ('_machine_', str(machine_number)),
            ('_isotope_', str(isotope_number)),
        ]

    def run(self):
        self._prepare_and_execute(calculation_sets.calc_corr_t)
        self._prepare_and_execute(calculation_sets.calc_sample_t)
        self._prepare_and_execute(calculation_sets.calc_set_t)
        self._prepare_and_execute(targets.sampletype_t)
        self._prepare_and_execute(targets.target_v)
        self._prepare_and_execute(results.workana_v)
        self._prepare_and_execute(results.workproto_v_nt)
        self._prepare_and_execute(routines.setCycleEnableNT)
        self._prepare_and_execute(routines.setRunEnableNT)

    def _prepare_and_execute(self, query, *args):
        self._execute(self._prepare(query), *args)

    def _prepare(self, query):
        for schema_mapping in self.schema_mappings:
            query = query.replace(*schema_mapping)

        return query

    def _execute(self, query, *args):
        with self.db_session.cursor() as cursor:
            cursor.execute(query, args)
            self.db_session.commit()
