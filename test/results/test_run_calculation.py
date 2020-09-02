#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import datetime

from pytest import approx


def some_cycles(seed_data, number_of_cycles=20):
    return [
        seed_data.add_cycle(
            number=i,
            runtime=1,
            end_of_cycle=datetime.datetime.utcnow(),
            enabled=i % 3 != 0,
            r=1e6,
            g1=2e6,
            g2=3e6,
            ana=1e-5,
            a=1e-6,
            b=2e-6,
            c=3e-6,
        )
        for i in range(number_of_cycles)
    ]


def test_calculate_run(orm, seed_data):
    cycles = some_cycles(seed_data)

    orm.session.execute(f'call calculate_run({seed_data.run.id})')
    orm.commit()

    run = seed_data.run
    assert run.enabled_cycles == 13
    assert run.total_cycles == 20

    assert run.runtime == approx(13)
    assert run.end_of_last_cycle == cycles[-1].end_of_cycle

    assert run.r == 13e6
    assert run.r_delta == approx(0.0277350098)

    assert run.g1 == approx(26e6)
    assert run.g1_delta == approx(0.0196116135)

    assert run.g2 == approx(39e6)
    assert run.g2_delta == approx(0.0160128154)

    assert run.ana == approx(1e-5)
    assert run.a == approx(1e-6)
    assert run.b == approx(2e-6)
    assert run.c == approx(3e-6)

    ratio = 0.1602177
    assert run.ratio_r_a == approx(ratio)
    assert run.ratio_r_a_delta == approx(0.0002773501)
    assert run.ratio_r_a_sigma is None

    assert run.ratio_r_b == approx(ratio / 2)
    assert run.ratio_r_b_delta == approx(0.0002773501)
    assert run.ratio_r_b_sigma is None

    assert run.ratio_g1_a == approx(ratio * 2)
    assert run.ratio_g1_b == approx(ratio)
    assert run.ratio_g2_a == approx(ratio * 3)
    assert run.ratio_g2_b == approx(ratio * 1.5)

    assert run.ratio_b_a == approx(2)
    assert run.ratio_b_a_delta == approx(0.2773500981)
    assert run.ratio_b_a_sigma == approx(0)

    assert run.ratio_a_ana == approx(0.1)
    assert run.ratio_a_ana_sigma == approx(9.210810886394641e-07)


def test_calculate_run_real_data(orm, seed_data, real_run):

    orm.session.execute(f'call calculate_run({seed_data.run.id})')
    orm.commit()

    run = seed_data.run
    assert run.enabled_cycles == 15
    assert run.total_cycles == 15

    assert run.runtime == approx(293.887276)
    assert run.end_of_last_cycle == real_run[-1].end_of_cycle

    assert run.r == 83678
    assert run.r_delta == approx(0.34569599986721733)

    assert run.g1 == 41843
    assert run.g1_delta == approx(0.4888646031814621)

    assert run.g2 == 27892
    assert run.g2_delta == approx(0.5987701914326449)

    assert run.ana == approx(63.8993929931148)
    assert run.a == approx(30.247924531309074)
    assert run.b == approx(0.32356373641239233)
    assert run.c == approx(0.00130675180112255)

    assert run.ratio_r_a == approx(1.5081525913525388e-12)
    assert run.ratio_r_a_delta == approx(0.003456748856390589)
    assert run.ratio_r_a_sigma == approx(0.29659744253453035)

    assert run.ratio_r_b == approx(1.4098758249307175e-10)
    assert run.ratio_r_b_delta == approx(0.003456752025438527)
    assert run.ratio_r_b_sigma == approx(0.29508154081373933)

    assert run.ratio_g1_a == approx(7.541484453076909e-13)
    assert run.ratio_g1_b == approx(7.05005358482368e-11)
    assert run.ratio_g2_a == approx(5.027055525780205e-13)
    assert run.ratio_g2_b == approx(4.6994740616329425e-11)

    assert run.ratio_b_a == approx(0.010697055795596073)
    assert run.ratio_b_a_delta == approx(0.25820184137625185)
    assert run.ratio_b_a_sigma == approx(0.017751250350184516)

    assert run.ratio_a_ana == approx(0.4733681824521881)
    assert run.ratio_a_ana_sigma == approx(0.018798174967380087)


def test_performance_of_calculate_run(orm, seed_data, benchmark):
    cycles = [
        seed_data.add_cycle(
            number=i,
            runtime=1e-6,
            end_of_cycle=datetime.datetime.utcnow(),
            disabled=i % 3 == 0,
            r=1e6,
            g1=2e6,
            g2=3e6,
            ana=1e-5,
            a=1e-6,
            b=2e-6,
            c=3e-6,
        )
        for i in range(100)
    ]

    def calculate_run():
        orm.session.execute(f'call calculate_run({seed_data.run.id})')
        orm.commit()

    benchmark(calculate_run)

    assert seed_data.run.total_cycles == len(cycles)


def test_set_cycle_enabled(orm, seed_data):
    cycles = some_cycles(seed_data)
    cycle = cycles[-1]

    orm.session.execute(f'call set_cycle_enabled({cycle.id}, false)')
    orm.commit()

    assert bool(cycle.enabled) is False

    orm.session.execute(f'call set_cycle_enabled({cycle.id}, true)')
    orm.commit()

    assert bool(cycle.enabled) is True
