#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

def test_defaults(orm):
    assert orm.query(orm.isotope).get(1).name == 'Al26'
    assert orm.query(orm.isotope).get(2).name == 'Be10'
    assert orm.query(orm.isotope).get(3).name == 'C14'
    assert orm.query(orm.isotope).get(4).name == 'Ca41'
    assert orm.query(orm.isotope).get(5).name == 'I129'
    assert orm.query(orm.isotope).get(6).name == 'Pu'
    assert orm.query(orm.isotope).get(7).name == 'Si32'
    assert orm.query(orm.isotope).get(8).name == 'U'
