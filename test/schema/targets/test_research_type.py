#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.research_type).get('undefined').sort_order == 0
    assert orm.query(orm.research_type).get('materials').sort_order == 10
    assert orm.query(orm.research_type).get('archeology').sort_order == 20
    assert orm.query(orm.research_type).get('climate').sort_order == 30
    assert orm.query(orm.research_type).get('water').sort_order == 40
    assert orm.query(orm.research_type).get('air').sort_order == 50
    assert orm.query(orm.research_type).get('soil').sort_order == 60
    assert orm.query(orm.research_type).get('plants').sort_order == 70
    assert orm.query(orm.research_type).get('art').sort_order == 80
    assert orm.query(orm.research_type).get('geochronology').sort_order == 90
    assert orm.query(orm.research_type).get('bomb peak').sort_order == 100
    assert orm.query(orm.research_type).get('geology').sort_order == 110
    assert orm.query(orm.research_type).get('ocean').sort_order == 120
    assert orm.query(orm.research_type).get('biogeochemistry').sort_order == 130
    assert orm.query(orm.research_type).get('environment').sort_order == 140
    assert orm.query(orm.research_type).get('physics').sort_order == 150
    assert orm.query(orm.research_type).get('reference material').sort_order == 160
