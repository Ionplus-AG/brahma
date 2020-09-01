#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import datetime
from pytest import approx

MAGAZINE_INIT_DATE = datetime.datetime.fromisoformat('2000-01-01 08:15')


def test_insert_updates_magazine_last_changed(orm, seed_data):
    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    seed_data.add_target(
        number=31415,
        magazine_id=seed_data.magazine.id
    )

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE


def test_update_updates_magazine_last_changed(orm, seed_data):
    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    seed_data.target.magazine_id = seed_data.magazine.id
    orm.commit()

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE


def test_delete_updates_magazine_last_changed(orm, seed_data):
    target = orm.add(orm.target(
        isotope_number=seed_data.preparation.isotope_number,
        sample_number=seed_data.preparation.sample_number,
        preparation_number=seed_data.preparation.number,
        number=31415,
        magazine_id=seed_data.magazine.id,
    ))
    orm.commit()

    seed_data.magazine.last_changed = MAGAZINE_INIT_DATE
    orm.commit()

    orm.delete(target)
    orm.commit()

    assert seed_data.magazine.last_changed > MAGAZINE_INIT_DATE


def test_designator(seed_data):
    assert seed_data.target.designator == '3.42.4711.1'


def test_calculate_target_real_data(orm, seed_data, real_target):
    orm.session.execute(f'call calculate_target({seed_data.target.id})')
    orm.commit()

    target = seed_data.target
    assert target.active_runs == 22
    assert target.total_runs == 23

    assert target.runtime == approx(6459.31732)

    assert target.r == 1881764
    assert target.r_delta == approx(0.07289830360608504)

    assert target.g1 == 940965
    assert target.g1_delta == approx(0.1030892227209303)

    assert target.g2 == 627255
    assert target.g2_delta == approx(0.12626353208207786)

    assert target.ana == approx(65.68611534570034)
    assert target.a == approx(30.658381006926604)
    assert target.b == approx(0.32984206997023646)
    assert target.c == approx(0.001585735383379493)

    assert target.ratio_r_a == approx(1.5224382121497404e-12)
    assert target.ratio_r_a_delta == approx(0.0007289503380028673)
    assert target.ratio_r_a_sigma == approx(0.20716356067219016)

    assert target.ratio_r_b == approx(1.4150571829826453e-10)
    assert target.ratio_r_b_delta == approx(0.0007289889351473053)
    assert target.ratio_r_b_sigma == approx(0.10743409752215699)

    assert target.ratio_g1_a == approx(7.541484453076909e-13)
    assert target.ratio_g1_b == approx(7.05005358482368e-11)
    assert target.ratio_g2_a == approx(5.027055525780205e-13)
    assert target.ratio_g2_b == approx(4.6994740616329425e-11)

    assert target.ratio_b_a == approx(0.010758626487671206)
    assert target.ratio_b_a_delta == approx(0.21319172202223693)
    assert target.ratio_b_a_sigma == approx(0.10963614299742935)

    assert target.ratio_a_ana == approx(0.4667942370495189)
    assert target.ratio_a_ana_sigma == approx(0.23133451244057593)


def test_performance_of_calculate_target(orm, seed_data, real_target, benchmark):
    def calculate_target():
        orm.session.execute(f'call calculate_target({seed_data.target.id})')
        orm.commit()

    benchmark(calculate_target)

    assert seed_data.target.total_runs == 23
