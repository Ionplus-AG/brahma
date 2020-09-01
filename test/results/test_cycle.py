#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import datetime
import pytest


def _check_ratios(cycle):
    ratio = 0.1602177
    assert cycle.ratio_r_a == pytest.approx(ratio)
    assert cycle.ratio_r_b == pytest.approx(ratio / 2)
    assert cycle.ratio_g1_a == pytest.approx(ratio * 2)
    assert cycle.ratio_g1_b == pytest.approx(ratio)
    assert cycle.ratio_g2_a == pytest.approx(ratio * 3)
    assert cycle.ratio_g2_b == pytest.approx(ratio * 1.5)
    assert cycle.ratio_b_a == pytest.approx(2)
    assert cycle.ratio_a_ana == pytest.approx(0.1)


def test_ratios_insert(seed_data):
    cycle = seed_data.add_cycle(
        number=1,
        end_of_cycle=datetime.datetime.utcnow(),
        r=1e6,
        g1=2e6,
        g2=3e6,
        a=1e-6,
        b=2e-6,
        ana=1e-5,
        runtime=1,
    )

    _check_ratios(cycle)


def test_ratios_update(orm, seed_data):
    cycle = seed_data.add_cycle(
        number=1,
        runtime=1,
        end_of_cycle=datetime.datetime.utcnow()
    )

    cycle.r = 1e6
    cycle.g1 = 2e6
    cycle.g2 = 3e6
    cycle.a = 1e-6
    cycle.b = 2e-6
    cycle.ana = 1e-5
    orm.commit()

    _check_ratios(cycle)


def test_ratios_of_real_data(seed_data):
    cycle = seed_data.add_cycle(
        number=366883,
        runtime=19.599998,
        end_of_cycle=datetime.datetime.fromisoformat('2019-10-19 16:40:06'),
        r=5211,
        g1=5211 / 2,
        g2=5211 / 3,
        a=28.506482509845153,
        b=0.30556084758324975,
        c=0.0013314440144330626,
        ana=60.36418985348876,
    )

    assert cycle.ratio_r_a == pytest.approx(1.4942792703431726e-12)
    assert cycle.ratio_r_b == pytest.approx(1.394047903118753e-10)
    assert cycle.ratio_g1_a == pytest.approx(cycle.ratio_r_a / 2)
    assert cycle.ratio_g1_b == pytest.approx(cycle.ratio_r_b / 2)
    assert cycle.ratio_g2_a == pytest.approx(cycle.ratio_r_a / 3)
    assert cycle.ratio_g2_b == pytest.approx(cycle.ratio_r_b / 3)
    assert cycle.ratio_b_a == pytest.approx(0.01071899514356847)
    assert cycle.ratio_a_ana == pytest.approx(0.4722416150872538)


def test_ratio_is_none_when_count_is_none(seed_data):
    cycle = seed_data.add_cycle(
        number=1,
        end_of_cycle=datetime.datetime.utcnow(),
        r=None,
        a=1e-6,
        runtime=1e-6,
    )

    assert cycle.ratio_r_a is None


def test_ratio_is_none_when_current_is_none(seed_data):
    cycle = seed_data.add_cycle(
        number=1,
        end_of_cycle=datetime.datetime.utcnow(),
        r=1e6,
        a=None,
        runtime=1e-6,
    )

    assert cycle.ratio_r_a is None


def test_ratio_is_none_when_runtime_is_zero(seed_data):
    cycle = seed_data.add_cycle(
        number=1,
        end_of_cycle=datetime.datetime.utcnow(),
        r=1e6,
        a=1e-6,
        runtime=0,
    )

    assert cycle.ratio_r_a is None
