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
            runtime=1,
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


real_data = (
    # number, runtime, end_of_cycle, r, g1, g2, ana, a, b, c
    (1, 19.599998, '2019-10-19 16:40:06', 5211, 2606, 1737, 60.36418985348876, 28.506482509845153, 0.30556084758324975, 0.0013314440144330626),
    (2, 19.595173, '2019-10-19 16:40:27', 5570, 2785, 1857, 62.3278480572741, 29.48039470894184, 0.3156586392161478, 0.0013033795756740704),
    (3, 19.595269, '2019-10-19 16:40:48', 5599, 2800, 1866, 63.170908559612016, 29.89606449342441, 0.3199351625081034, 0.0013046336495814372),
    (4, 19.591749999999998, '2019-10-19 16:41:08', 5544, 2772, 1848, 63.67678487118303, 30.138744241836495, 0.3224688059387243, 0.0013045482154478288),
    (5, 19.597058, '2019-10-19 16:41:29', 5524, 2762, 1841, 64.02923277565438, 30.310583597803305, 0.3242861362766799, 0.0013048606285698597),
    (6, 19.584075, '2019-10-19 16:41:50', 5566, 2783, 1855, 64.2952595412344, 30.444809532745357, 0.3255887257057074, 0.0013070650132824759),
    (7, 19.595710999999998, '2019-10-19 16:42:11', 5630, 2815, 1877, 64.48109271462516, 30.535273050822198, 0.326484465819842, 0.0013089059585538899),
    (8, 19.583021, '2019-10-19 16:42:32', 5725, 2863, 1908, 64.59071844941595, 30.581876417841766, 0.3270248660380337, 0.0013084993265339397),
    (9, 19.596047, '2019-10-19 16:42:52', 5574, 2787, 1858, 64.61919542242372, 30.593024999889007, 0.3271881816018813, 0.0013083118003340162),
    (10, 19.583387, '2019-10-19 16:43:13', 5673, 2837, 1891, 64.57092037245651, 30.57374575552227, 0.3269324424224983, 0.001308198940765456),
    (11, 19.591192, '2019-10-19 16:43:34', 5591, 2796, 1864, 64.52061526424731, 30.54488939315178, 0.3266850046714871, 0.0013068468769026407),
    (12, 19.597293999999998, '2019-10-19 16:43:55', 5591, 2796, 1864, 64.49066596643394, 30.536473226354623, 0.3265182449694331, 0.0013035997245333974),
    (13, 19.585535999999998, '2019-10-19 16:44:16', 5631, 2816, 1877, 64.48140570674195, 30.539797417849588, 0.32651253048780493, 0.0013018711686011556),
    (14, 19.594082, '2019-10-19 16:44:36', 5677, 2839, 1892, 64.43757781558739, 30.5153633949271, 0.3262881347587501, 0.0013006457347682836),
    (15, 19.597683, '2019-10-19 16:44:57', 5572, 2786, 1857, 64.43662056376766, 30.52239433253411, 0.3263346870818862, 0.0012984608012079795),
)


def test_calculate_run_real_data(orm, seed_data):
    cycles = [
        seed_data.add_cycle(
            number=d[0],
            runtime=d[1],
            end_of_cycle=datetime.datetime.fromisoformat(d[2]),
            r=d[3],
            g1=d[4],
            g2=d[5],
            ana=d[6],
            a=d[7],
            b=d[8],
            c=d[9],
        )
        for d in real_data
    ]

    orm.session.execute(f'call calculate_run({seed_data.run.id})')
    orm.commit()

    run = seed_data.run
    assert run.enabled_cycles == 15
    assert run.total_cycles == 15

    assert run.runtime == approx(293.887276)
    assert run.end_of_last_cycle == cycles[-1].end_of_cycle

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
