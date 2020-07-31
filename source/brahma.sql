#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

source tables/customer.sql;
source tables/schema_change.sql;

insert into schema_change (version, date_applied) values (1, NOW());
