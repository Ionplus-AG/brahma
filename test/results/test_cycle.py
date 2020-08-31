#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import datetime
import pytest


def _check_ratios(cycle):
    ratio = 0.1602177
    assert float(cycle.ratio_r_a) == pytest.approx(ratio)
    assert float(cycle.ratio_r_b) == pytest.approx(ratio / 2)
    assert float(cycle.ratio_g1_a) == pytest.approx(ratio * 2)
    assert float(cycle.ratio_g1_b) == pytest.approx(ratio)
    assert float(cycle.ratio_g2_a) == pytest.approx(ratio * 3)
    assert float(cycle.ratio_g2_b) == pytest.approx(ratio * 1.5)
    assert float(cycle.ratio_b_a) == pytest.approx(2)
    assert float(cycle.ratio_a_ana) == pytest.approx(0.1)


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
        runtime=1e-6,
    )

    _check_ratios(cycle)


def test_ratios_update(orm, seed_data):
    cycle = seed_data.add_cycle(
        number=1,
        runtime=1e-6,
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
