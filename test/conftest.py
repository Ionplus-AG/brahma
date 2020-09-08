#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

pytest_plugins = [
   "test.fixtures.database",
   "test.fixtures.orm",
   "test.fixtures.real_data",
   "test.fixtures.seed_data",
]
