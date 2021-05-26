#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import pytest
import sqlalchemy
import sqlalchemy.orm

from sqlalchemy.ext.automap import automap_base


Base = automap_base()


class Orm(object):
    def __init__(self, base, session):
        self.__base = base
        self.session = session

    @property
    def schema_change(self):
        return self.__base.classes.schema_change

    @property
    def customer(self):
        return self.__base.classes.customer

    @property
    def fraction(self):
        return self.__base.classes.fraction

    @property
    def material(self):
        return self.__base.classes.material

    @property
    def project(self):
        return self.__base.classes.project

    @property
    def project_advisor(self):
        return self.__base.classes.project_advisor

    @property
    def project_status(self):
        return self.__base.classes.project_status

    @property
    def project_type(self):
        return self.__base.classes.project_type

    @property
    def isotope(self):
        return self.__base.classes.isotope

    @property
    def sample(self):
        return self.__base.classes.sample

    @property
    def sample_type(self):
        return self.__base.classes.sample_type

    @property
    def preparation(self):
        return self.__base.classes.preparation

    @property
    def preparation_method(self):
        return self.__base.classes.preparation_method

    @property
    def report_type(self):
        return self.__base.classes.report_type

    @property
    def research_type(self):
        return self.__base.classes.research_type

    @property
    def target(self):
        return self.__base.classes.target

    @property
    def magazine(self):
        return self.__base.classes.magazine

    @property
    def measurement_sequence(self):
        return self.__base.classes.measurement_sequence

    @property
    def machine(self):
        return self.__base.classes.machine

    @property
    def cycle_definition(self):
        return self.__base.classes.cycle_definition

    @property
    def run(self):
        return self.__base.classes.run

    @property
    def cycle(self):
        return self.__base.classes.cycle

    def add(self, obj):
        self.session.add(obj)
        return obj

    def query(self, table):
        return self.session.query(table)

    def delete(self, obj):
        self.session.delete(obj)

    def commit(self):
        return self.session.commit()

    def rollback(self):
        return self.session.rollback()


@pytest.fixture(scope='session')
def orm_engine(request, brahma_schema):
    config = request.config
    host = config.getini('mysql_host')
    user = config.getini('mysql_user')
    passwd = config.getini('mysql_password')
    database_name = config.getini('mysql_database_name')
    yield sqlalchemy.create_engine(f'mysql+mysqlconnector://{user}:{passwd}@{host}/{database_name}')


# noinspection PyUnusedLocal
def _no_relationship(*args, **kw):
    return None


@pytest.fixture(scope='session')
def orm_base(orm_engine):
    metadata = sqlalchemy.MetaData()
    metadata.reflect(orm_engine)

    # map all double columns to float
    for table in metadata.tables.values():
        for column in table.columns.values():
            if isinstance(column.type, sqlalchemy.Numeric):
                column.type.asdecimal = False

    base = automap_base(metadata=metadata)
    base.prepare(
        orm_engine,
        generate_relationship=_no_relationship
    )
    yield base


@pytest.fixture(scope='function')
def orm(orm_engine, orm_base):
    session = sqlalchemy.orm.Session(orm_engine)
    yield Orm(orm_base, session)
