#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

insert into customer (number, last_name)
values (1, 'test_customer_1');

insert into project (number, name, correspondence_customer_number, invoice_customer_number)
values (11, 'test_project_11', 1, 1);

insert into sample (isotope_number, number, project_number)
values (3, 101, 11);

insert into preparation (isotope_number, sample_number, number)
values (3, 101, 1001);

insert into target (id, isotope_number, sample_number, preparation_number, number)
values (10001, 3, 101, 1001, 10001);
