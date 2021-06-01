#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.material).get('undefined').sort_order == 0
    assert orm.query(orm.material).get('CO2').sort_order == 80
    assert orm.query(orm.material).get('coal').sort_order == 100
    assert orm.query(orm.material).get('oil').sort_order == 380
    assert orm.query(orm.material).get('pollen').sort_order == 510
    assert orm.query(orm.material).get('wine').sort_order == 710
    assert orm.query(orm.material).get('aerosol').sort_order == 720
