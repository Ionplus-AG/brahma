#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

research_type = [
    ('undefined', 0),
    ('materials', 10),
    ('archeology', 20),
    ('climate', 30),
    ('water', 40),
    ('air', 50),
    ('soil', 60),
    ('plants', 70),
    ('art', 80),
    ('geochronology', 90),
    ('bomb peak', 100),
    ('geology', 110),
    ('ocean', 120),
    ('biogeochemistry', 130),
    ('environment', 140),
    ('physics', 150),
    ('reference material', 160)
]


def seed(cursor):
    cursor.executemany("insert into research_type (name, sort_order) values (%s, %s)", research_type)
