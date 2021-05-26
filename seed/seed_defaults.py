#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

from seed import isotope

def seed_defaults(session):
    with session.cursor() as cursor:
        isotope.seed_isotopes(cursor)
    session.commit()
