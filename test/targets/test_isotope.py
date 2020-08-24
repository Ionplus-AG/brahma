#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

def test_defaults(db_cursor):
    db_cursor.execute('select * from isotope order by isotope.number')
    assert db_cursor.fetchall() == [(1, 'Al26', '^{26}Al'),
                                    (2, 'Be10', '^{10}Be'),
                                    (3, 'C14', '^{14}C'),
                                    (4, 'Ca41', '^{41}Ca'),
                                    (5, 'I129', '^{129}I'),
                                    (6, 'Pu', 'Pu'),
                                    (7, 'Si32', '^{32}Si'),
                                    (8, 'U', 'U')]
