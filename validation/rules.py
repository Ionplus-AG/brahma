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


_cycles_without_run_error = 'workana without matching workproto: run: {}, cycle: {}'
_cycles_without_run_query = '''
select
  workana.RUN,
  workana.CYCLE

from _ac14_.workana

left join _ac14_.workproto on workana.RUN = workproto.RUN

where workproto.RUN is null
'''

_runs_without_target_error = 'workproto without matching target: run: {}, target: {}.{}.{}'
_runs_without_target_query = '''
select
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

_targets_with_multiple_run_prefixes_error = 'target with multiple run-prefixes: target: {}, runs: {}'
_targets_with_multiple_run_prefixes_query = '''
select
  grouped.target,
  grouped.runs

from (
  select
    flat.target,
    count(distinct flat.prefix) as prefixes_count,
    group_concat(flat.run order by flat.run separator ', ') as runs

  from (
    select
      concat(SAMPLE_NR, '.', PREP_NR, '.', TARGET_NR) as target,
      regexp_replace(RUN, '[0-9]', '') as prefix,
      run

    from _ac14_.workproto
  ) as flat

  group by flat.target
) as grouped

where grouped.prefixes_count > 1
'''

_calc_samples_without_target_error = 'calc_sample without matching target: calcset: {}, target: {}.{}.{}'
_calc_samples_without_target_query = '''
select
  calc_sample_t.calcset,
  calc_sample_t.sample_nr,
  calc_sample_t.prep_nr,
  calc_sample_t.target_nr

from _ams_.calc_sample_t
left join _ams_.target_t
on calc_sample_t.sample_nr = target_t.sample_nr
  and calc_sample_t.prep_nr = target_t.prep_nr
  and calc_sample_t.target_nr = target_t.target_nr

where target_t.target_nr is null
'''

tutti = [
    _Rule(_cycles_without_run_query, _cycles_without_run_error),
    _Rule(_runs_without_target_query, _runs_without_target_error),
    _Rule(_targets_with_multiple_run_prefixes_query, _targets_with_multiple_run_prefixes_error),
    _Rule(_calc_samples_without_target_query, _calc_samples_without_target_error),
]
