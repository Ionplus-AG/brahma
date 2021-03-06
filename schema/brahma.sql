#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

set names utf8mb4;

source projects/customer.sql;
source projects/project_advisor.sql;
source projects/project_status.sql;
source projects/project_type.sql;
source projects/report_type.sql;
source projects/research_type.sql;
source projects/project.sql;

source targets/isotope.sql;
source targets/fraction.sql;
source targets/material.sql;
source targets/sample_type.sql;
source targets/sample.sql;
source targets/preparation_method.sql;
source targets/preparation.sql;
source targets/magazine.sql;
source targets/target.sql;
source targets/measurement_sequence.sql;

source results/machine.sql;
source results/cycle_definition.sql;
source results/run.sql;
source results/cycle.sql;

source misc/schema_change.sql;
source misc/config_variable.sql;

source calculation_sets/calculation_set.sql;
source calculation_sets/calculation_correction.sql;
source calculation_sets/calculation_sample.sql;

source routines/safe_ratio.sql;
source routines/count_by_current_ratio.sql;
source routines/calculate_cycle_ratios.sql;
source routines/calculate_run.sql;
source routines/calculate_target.sql;
source routines/update_run.sql;
source routines/set_cycle_enabled.sql;
source routines/set_run_enabled.sql;

insert into schema_change (version, date_applied) values (1, NOW());
