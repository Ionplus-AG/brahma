#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import datetime

from pytest import approx


def test_calculate_run(orm, seed_data):
    cycles = [
        seed_data.add_cycle(
            number=i,
            runtime_micros=1,
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
        for i in range(20)
    ]

    orm.session.execute(f'call calculate_run({seed_data.run.id})')
    orm.commit()

    run = seed_data.run
    assert run.enabled_cycles == 13
    assert run.total_cycles == 20

    assert run.runtime_micros == approx(13)
    assert run.end_of_last_cycle == cycles[-1].end_of_cycle

    assert run.r == approx(13e6)
    assert float(run.r_delta) == approx(0.0277350098)

    assert run.g1 == approx(26e6)
    assert float(run.g1_delta) == approx(0.0196116135)

    assert run.g2 == approx(39e6)
    assert float(run.g2_delta) == approx(0.0160128154)

    assert float(run.ana) == approx(1e-5)
    assert float(run.a) == approx(1e-6)
    assert float(run.b) == approx(2e-6)
    assert float(run.c) == approx(3e-6)

    ratio = 0.1602177
    assert float(run.ratio_r_a) == approx(ratio)
    assert float(run.ratio_r_a_delta) == approx(0.0002773501)
    assert run.ratio_r_a_sigma is None

    assert float(run.ratio_r_b) == approx(ratio / 2)
    assert float(run.ratio_r_b_delta) == approx(0.0002773501)
    assert run.ratio_r_b_sigma is None

    assert float(run.ratio_g1_a) == approx(ratio * 2)
    assert float(run.ratio_g1_b) == approx(ratio)
    assert float(run.ratio_g2_a) == approx(ratio * 3)
    assert float(run.ratio_g2_b) == approx(ratio * 1.5)

    assert float(run.ratio_b_a) == approx(2)
    assert float(run.ratio_b_a_delta) == approx(0.2773500981)
    assert float(run.ratio_b_a_sigma) == approx(0)

    assert float(run.ratio_a_ana) == approx(0.1)
    assert float(run.ratio_a_ana_sigma) == approx(9.211e-07)


def test_performance_of_calculate_run(orm, seed_data, benchmark):
    cycles = [
        seed_data.add_cycle(
            number=i,
            runtime_micros=1,
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

    benchmark(calculate_run)

    orm.commit()
    assert seed_data.run.total_cycles == len(cycles)
