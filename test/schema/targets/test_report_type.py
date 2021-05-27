#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.report_type).get('undefined').sort_order == 0
    assert orm.query(orm.report_type).get('standard').sort_order == 10
