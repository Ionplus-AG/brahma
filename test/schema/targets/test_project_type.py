#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.project_type).get('undefined').sort_order == 0
    assert orm.query(orm.project_type).get('research contracts').sort_order == 10
    assert orm.query(orm.project_type).get('eu').sort_order == 20
    assert orm.query(orm.project_type).get('internal').sort_order == 30
    assert orm.query(orm.project_type).get('commercial').sort_order == 40
