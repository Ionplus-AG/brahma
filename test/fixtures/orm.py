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
        self.__session = session

    @property
    def customer(self):
        return self.__base.classes.customer

    @property
    def project(self):
        return self.__base.classes.project

    @property
    def sample(self):
        return self.__base.classes.sample

    @property
    def preparation(self):
        return self.__base.classes.preparation

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

    def add(self, obj):
        self.__session.add(obj)

    def query(self, table):
        return self.__session.query(table)

    def delete(self, obj):
        self.__session.delete(obj)

    def commit(self):
        return self.__session.commit()

    def rollback(self):
        return self.__session.rollback()


@pytest.fixture(scope='session')
def orm_engine(request, db_connection):
    config = request.config
    host = config.getini('mysql_host')
    user = config.getini('mysql_user')
    passwd = config.getini('mysql_password')
    database_name = config.getini('mysql_database_name')
    yield sqlalchemy.create_engine(f'mysql://{user}:{passwd}@{host}/{database_name}')


# noinspection PyUnusedLocal
def _no_relationship(*args, **kw):
    return None


@pytest.fixture(scope='session')
def orm_base(orm_engine):
    base = automap_base()
    base.prepare(
        orm_engine,
        reflect=True,
        generate_relationship=_no_relationship
    )
    yield base


@pytest.fixture(scope='function')
def orm(orm_engine, orm_base):
    session = sqlalchemy.orm.Session(orm_engine)
    yield Orm(orm_base, session)
