#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

from migration.table_mapping import TableMapping


def test_table_mapping_implicit():
    sut = TableMapping('foo', 'bar')

    assert sut.to_query('ams', 'brahma') == '''insert into brahma.bar
select *
from ams.foo;'''


def test_table_mapping_explicit():
    sut = TableMapping('foo', 'bar', (
        ('s1', 't1'),
        ('s2', 't2'),
        ('s3', 't3'),
        ('st4',),
    ))

    assert sut.to_query('ams', 'brahma') == '''insert into brahma.bar (t1, t2, t3, st4)
select s1, s2, s3, st4
from ams.foo;'''
