#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

report_type = [
    ('undefined', 0),
    ('standard', 10)
]


def seed(cursor):
    cursor.executemany("insert into report_type (name, sort_order) values (%s, %s)", report_type)
