#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

from legacy import calculation_correction, calculation_sample, calculation_set, sampletype, target, workana, workproto


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
        self._prepare_and_execute(calculation_correction.calc_corr_t)
        self._prepare_and_execute(calculation_sample.calc_sample_t)
        self._prepare_and_execute(calculation_set.calc_set_t)
        self._prepare_and_execute(sampletype.sampletype_t)
        self._prepare_and_execute(target.target_v)
        self._prepare_and_execute(workana.workana_v)
        self._prepare_and_execute(workproto.workproto_v_nt)

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
