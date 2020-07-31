#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

source tables/customer.sql;

source tables/project_advisor.sql;
source tables/project_status.sql;
source tables/project_type.sql;
source tables/report_type.sql;
source tables/research_type.sql;
source tables/project.sql;

source tables/isotope.sql;

source tables/schema_change.sql;

insert into schema_change (version, date_applied) values (1, NOW());
