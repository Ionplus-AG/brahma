#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.fraction).get('undefined').sort_order == 0
    assert orm.query(orm.fraction).get('black carbon').sort_order == 80
    assert orm.query(orm.fraction).get('bulk').sort_order == 84
    assert orm.query(orm.fraction).get('liquid').sort_order == 230
    assert orm.query(orm.fraction).get('solid').sort_order == 290
    assert orm.query(orm.fraction).get('wine').sort_order == 350
