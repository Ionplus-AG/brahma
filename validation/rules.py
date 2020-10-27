#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

class _Rule(object):
    def __init__(self, query, template):
        self.query = query
        self.template = template

    def format_error(self, result):
        return self.template.format(*result)


_cycles_without_run_error = 'workana without matching workproto: recno: {}, run: {}, cycle: {}'
_cycles_without_run_query = '''
select
  workana.RECNO,
  workana.RUN,
  workana.CYCLE

from _ac14_.workana

left join _ac14_.workproto on workana.RUN = workproto.RUN

where workproto.RUN is null
'''

_runs_without_target_error = 'workproto without matching target: recno: {}, run {}, target: {}.{}.{}'
_runs_without_target_query = '''
select
  workproto.RECNO,
  workproto.RUN,
  workproto.SAMPLE_NR,
  workproto.PREP_NR,
  workproto.TARGET_NR

from _ac14_.workproto

left join _ams_.target_t
on workproto.SAMPLE_NR = target_t.sample_nr
  and workproto.PREP_NR = target_t.prep_nr
  and workproto.TARGET_NR = target_t.target_nr

where target_t.target_nr is null
'''

tutti = [
    _Rule(_cycles_without_run_query, _cycles_without_run_error),
    _Rule(_runs_without_target_query, _runs_without_target_error),
]
