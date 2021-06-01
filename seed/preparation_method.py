#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

preparation_method = [
    ('undefined', None, 0),
    ('Acid 60°', None, 1),
    ('ABA 60°', None, 2),
    ('fumigation', None, 4),
    ('combustion', None, 6),
    ('gc', None, 8),
    ('ABA 20°', None, 10),
    ('ABOX', None, 20),
    ('acidification', None, 24),
    ('alphacellulose', None, 30),
    ('cellulose BABAB', None, 40),
    ('cellulose BBB', None, 42),
    ('collagene', None, 50),
    ('cremated bones wash', None, 51),
    ('column', None, 60),
    ('Cu oxid', None, 80),
    ('drying 60C', None, 82),
    ('filtration', None, 84),
    ('freeze drying', None, 90),
    ('heavy liquid', None, 100),
    ('hemicellulose', None, 110),
    ('hplc', None, 120),
    ('hypy', None, 128),
    ('insitu quartz', None, 130),
    ('leaching', None, 140),
    ('longin+base', None, 150),
    ('microwave extraction', None, 160),
    ('multivap', None, 165),
    ('NaOH absorption', None, 167),
    ('pollen', None, 170),
    ('pyrolysis', None, 175),
    ('ramped pyrolysis', None, 178),
    ('sieving', None, 180),
    ('soxhlet', None, 190),
    ('step comb', None, 200),
    ('SrCl2 precipitation', None, 206),
    ('ultra sonic', None, 210),
    ('ultrafiltration', None, 220),
    ('WCO', None, 230)
]


def seed(cursor):
    cursor.executemany("insert into preparation_method (name, description, sort_order) values (%s, %s, %s)",
                       preparation_method)
