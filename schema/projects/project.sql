#
# copyright (c) Ionplus AG and contributors. all rights reserved.
# licensed under the mit license. see license file in the project root for details.
#

create table project (
    number int auto_increment primary key,
    name varchar(30) not null,
    type varchar(20),
    advisor varchar(10),
    customer_number int not null,
    invoice_customer_number int not null,
    in_date date,
    out_date date,
    desired_date date,
    priority smallint,
    report_type varchar(20),
    letter varchar(120),
    comment text,
    status varchar(20),
    price varchar(100),
    research_type varchar(20),
    invoice int unsigned, # TODO, ewc 2020-07-31: what is stored in this field?
    invoice_date date,

    constraint project_customer_foreign_key
    foreign key (customer_number) references customer(number),

    constraint project_invoice_customer_foreign_key
    foreign key (invoice_customer_number) references customer(number),

    constraint project_type_foreign_key
    foreign key (type) references project_type(name),

    constraint report_type_foreign_key
    foreign key (report_type) references report_type(name),

    constraint project_research_type_foreign_key
    foreign key (research_type) references research_type(name),

    constraint project_status_foreign_key
    foreign key (status) references project_status(name),

    constraint project_advisor_foreign_key
    foreign key (advisor) references project_advisor(name)

) engine=innodb;
