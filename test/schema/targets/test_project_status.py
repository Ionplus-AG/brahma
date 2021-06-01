#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.project_status).get('planned').sort_order == 1
    assert orm.query(orm.project_status).get('running').sort_order == 2
    assert orm.query(orm.project_status).get('closed').sort_order == 3
