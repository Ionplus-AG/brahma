#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import pytest

import migration
import migration.session


def test_table_mapping_implicit():
    sut = migration.session.TableMapping('foo', 'bar')

    assert sut.to_query('ams', 'brahma') == '''insert into brahma.bar
select *
from ams.foo;'''


def test_table_mapping_explicit():
    sut = migration.session.TableMapping('foo', 'bar', (
        ('s1', 't1'),
        ('s2', 't2'),
        ('s3', 't3'),
    ))

    assert sut.to_query('ams', 'brahma') == '''insert into brahma.bar (t1, t2, t3)
select s1, s2, s3
from ams.foo;'''


def test_migrate(db_session, ams_schema, brahma_schema):
    session = migration.Session(db_session, brahma_schema, *ams_schema)
    assert session.migrate_customer() == 1
