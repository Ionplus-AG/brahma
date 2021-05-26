#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

from seed import fraction
from seed import isotope
from seed import material
from seed import preparation_method
from seed import project_advisor
from seed import project_status
from seed import project_type
from seed import report_type
from seed import research_type
from seed import sample_type


def seed_defaults(session):
    with session.cursor() as cursor:
        fraction.seed(cursor)
        isotope.seed(cursor)
        material.seed(cursor)
        preparation_method.seed(cursor)
        project_advisor.seed(cursor)
        project_status.seed(cursor)
        project_type.seed(cursor)
        report_type.seed(cursor)
        research_type.seed(cursor)
        sample_type.seed(cursor)
    session.commit()
