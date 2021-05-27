#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import pathlib

import pytest

import database
import database.sql_script
import seed

brahma_sql = pathlib.Path(__file__).parent.parent.parent.absolute() / 'schema' / 'brahma.sql'
legacy_ams_sql = pathlib.Path(__file__).parent / 'legacy_ams.sql'
legacy_ac14_sql = pathlib.Path(__file__).parent / 'legacy_ac14.sql'


def pytest_addoption(parser):
    parser.addoption('--dev_schemas', action="store_true", default=False,
                     help="use _brahma_, _ams_ and _ac14_ for schema names")

    parser.addini('mysql_host', 'The host of the MySQL database', None, 'localhost')
    parser.addini('mysql_user', 'The MySQL database user', None, 'root')
    parser.addini('mysql_password', 'The MySQL users password', None)
    parser.addini('mysql_database_name', 'The MySQL database name', None, 'brahma_test')


def _create_session(config):
    return database.Session(
        host=config.getini('mysql_host'),
        user=config.getini('mysql_user'),
        password=config.getini('mysql_password'))


def _prepare_database(config, database_name, script_path):
    session = _create_session(config)

    with session.cursor() as cursor:
        cursor.execute(f'drop database if exists {database_name}')
        cursor.execute(f'create database {database_name} character set utf8mb4 collate utf8mb4_unicode_ci')

    database.sql_script.run(
        script_path,
        config.getini('mysql_host'),
        config.getini('mysql_user'),
        config.getini('mysql_password'),
        database_name,
    )

    session.database = database_name
    session.close()


@pytest.fixture(scope='session')
def db_session(request):
    session = _create_session(request.config)
    yield session
    session.close()


class SchemaNames(object):
    def __init__(self):
        self.brahma = '_brahma_'
        self.ams = '_ams_'
        self.ac14 = '_ac14_'


@pytest.fixture(scope='session')
def schema_names(request):
    names = SchemaNames()
    config = request.config

    if not config.getoption("--dev_schemas"):
        names.brahma = config.getini('mysql_database_name')
        names.ams = names.brahma + '_ams'
        names.ac14 = names.brahma + '_ac14'

    yield names


@pytest.fixture(scope='session')
def brahma_schema(request, schema_names):
    config = request.config
    _prepare_database(config, schema_names.brahma, brahma_sql)
    session = _create_session(config)
    session.database = schema_names.brahma
    seed.seed_defaults(session)
    session.close()

    yield schema_names.brahma


@pytest.fixture(scope='session')
def ams_schema(request, schema_names):
    config = request.config
    _prepare_database(config, schema_names.ams, legacy_ams_sql)
    _prepare_database(config, schema_names.ac14, legacy_ac14_sql)

    yield schema_names.ams, schema_names.ac14
