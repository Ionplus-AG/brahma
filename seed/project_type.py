#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

project_type = [
    ('undefined', 0),
    ('research contracts', 10),
    ('eu', 20),
    ('internal', 30),
    ('commercial', 40)
]


def seed(cursor):
    cursor.executemany("insert into project_type (name, sort_order) values (%s, %s)", project_type)
