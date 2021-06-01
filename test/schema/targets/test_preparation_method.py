#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.preparation_method).get('undefined').sort_order == 0
    assert orm.query(orm.preparation_method).get('combustion').sort_order == 6
    assert orm.query(orm.preparation_method).get('alphacellulose').sort_order == 30
    assert orm.query(orm.preparation_method).get('hemicellulose').sort_order == 110
    assert orm.query(orm.preparation_method).get('leaching').sort_order == 140
    assert orm.query(orm.preparation_method).get('pollen').sort_order == 170
    assert orm.query(orm.preparation_method).get('SrCl2 precipitation').sort_order == 206
    assert orm.query(orm.preparation_method).get('WCO').sort_order == 230
