#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

def test_dummy(ams_schema, brahma_schema):
    assert ams_schema == ('brahma_test_ams', 'brahma_test_ac14')
