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
source results/run_calculation.sql;
source results/cycle_calculation.sql;

source misc/schema_change.sql;
source misc/config_variable.sql;

insert into schema_change (version, date_applied) values (1, NOW());
