#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

sample_type = [
    ('sample', 0, None, None, None, None, -25, 0, 0),
    ('oxa1', 10, 1.0526, 0, -19.2, 0.1, -19, 0, 1),
    ('oxa2', 20, 1.34066, 0.0005, -17.8, 0.1, -25, 0, 1),
    ('bl', 30, None, None, None, None, -25, 1, 1),
    ('bl_carb', 40, None, None, None, None, -25, 1, 1),
    ('sample_hp', 60, None, None, None, None, -25, 0, 0),
    ('co2atm', 90, None, None, None, None, -25, 0, 0),
    ('tree_hp', 80, None, None, None, None, -25, 0, 0),
    ('wilhelm', 100, 9.9278, 0.0002, -23.5, None, -23.5, 0, 1),
    ('lnz', 110, 1.0462, 0.0025, -28.8, 0.1, -25, 0, 1),
    ('IAEA-C1', 200, 0, 0.0001, 2.42, 0.33, -25, 1, 1),
    ('IAEA-C2', 210, 0.4114, 0.0003, -8.25, 0.31, -25, 0, 0),
    ('IAEA-C3', 220, 1.2941, 0.0006, -24.724, 0.041, -25, 0, 0),
    ('IAEA-C4', 230, 0.0032, 0.0012, -23.96, 0.62, -25, 0, 0),
    ('IAEA-C5', 240, 0.2305, 0.0002, -25.49, 0.72, -25, 0, 0),
    ('IAEA-C6', 250, 1.506, 0.002, -10.449, 0.033, -25, 0, 0),
    ('IAEA-C7', 260, 0.4953, 0.0012, -14.48, 0.21, -25, 0, 0),
    ('IAEA-C8', 270, 0.1503, 0.0017, -18.31, 0.11, -25, 0, 0),
    ('IAEA-C9', 271, 0.0017, 0.0005, -23.9, 1.5, -25, 0, 0),
    ('cstd', 275, 0.9447, 0.0002, 0.57, 0.1, -25, 0, 0),
    ('standard', 280, None, None, None, None, -25, 0, 0),
    ('nb', 400, None, None, None, None, -25, 0, 0)
]


def seed(cursor):
    cursor.executemany(
        "insert into sample_type (name, sort_order, f14c, f14c_sigma, d13c, d13c_sigma, d13c_nominal, blank, active)"
        "values (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
        sample_type)
