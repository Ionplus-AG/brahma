#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import pytest
from sqlalchemy.exc import IntegrityError


class SeedData(object):
    def __init__(self, orm):
        self.__orm = orm
        self.__objects = []

        self.customer = self.add(orm.customer(last_name='test_customer'))
        self.project = self.add(orm.project(
            name='test_project',
            correspondence_customer_number=self.customer.number,
            invoice_customer_number=self.customer.number,
        ))
        self.sample = self.add_sample(isotope_number=3, number=42)
        self.preparation = self.add_preparation(number=4711)
        self.target = self.add_target(number=1)

        self.magazine = self.add(orm.magazine(name='test_mag'))
        self.machine = self.add(orm.machine(name='test machine', prefix='test'))

    def add_sample(self, project=None, **kwargs):
        if not project:
            project = self.project

        return self.add(self.__orm.sample(
            project_number=project.number,
            **kwargs,
        ))

    def add_preparation(self, sample=None, **kwargs):
        if not sample:
            sample = self.sample

        return self.add(self.__orm.preparation(
            isotope_number=sample.isotope_number,
            sample_number=sample.number,
            **kwargs,
        ))

    def add_target(self, preparation=None, **kwargs):
        if not preparation:
            preparation = self.preparation

        return self.add(self.__orm.target(
            isotope_number=preparation.isotope_number,
            sample_number = preparation.sample_number,
            preparation_number=preparation.number,
            **kwargs
        ))

    def add(self, obj):
        self.__orm.add(obj)
        self.__orm.commit()
        self.__objects.append(obj)
        return obj

    def cleanup(self):
        while self.__objects:
            obj = self.__objects.pop()
            try:
                self.__orm.delete(obj)
                self.__orm.commit()
            except IntegrityError as e:
                self.__orm.rollback()
                self.__objects.insert(0, obj)


@pytest.fixture(scope='function')
def seed_data(orm):
    data = SeedData(orm)
    yield data
    data.cleanup()

