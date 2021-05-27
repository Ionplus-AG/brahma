#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#


def test_defaults(orm):
    assert orm.query(orm.project_advisor).get('main user').sort_order == 10
    assert orm.query(orm.project_advisor).get('training').sort_order == 20
