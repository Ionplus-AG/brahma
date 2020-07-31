#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

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

source misc/schema_change.sql;
insert into schema_change (version, date_applied) values (1, NOW());
