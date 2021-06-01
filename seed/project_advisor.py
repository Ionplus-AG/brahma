#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

project_advisor = [
    ('main user', 10),
    ('training', 20)
]


def seed(cursor):
    cursor.executemany("insert into project_advisor (name, sort_order) values (%s, %s)", project_advisor)
