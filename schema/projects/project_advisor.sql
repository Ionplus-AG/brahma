#
# copyright (c) Ionplus AG and contributors. all rights reserved.
# licensed under the mit license. see license file in the project root for details.
#

create table project_advisor (
    name varchar(20) primary key,
    sort_order int not null
) engine=innodb;
