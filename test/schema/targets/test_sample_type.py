#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.sample_type).get('sample').sort_order == 0
    assert orm.query(orm.sample_type).get('oxa2').sort_order == 20
    assert orm.query(orm.sample_type).get('bl').sort_order == 30
    assert orm.query(orm.sample_type).get('lnz').sort_order == 110
    assert orm.query(orm.sample_type).get('nb').sort_order == 400
