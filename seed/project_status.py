#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

project_status = [
    ('planned', 1),
    ('running', 2),
    ('closed', 3)
]


def seed(cursor):
    cursor.executemany("insert into project_status (name, sort_order) values (%s, %s)", project_status)
