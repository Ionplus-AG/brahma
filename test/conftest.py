import os
import pathlib

import mysql.connector
import pytest


brahma_sql = pathlib.Path(__file__).parent.parent.absolute() / 'source' / 'brahma.sql'


def pytest_addoption(parser):
    parser.addini('mysql_host', 'The host of the MySQL database', None, 'localhost')
    parser.addini('mysql_user', 'The MySQL database user', None, 'root')
    parser.addini('mysql_password', 'The MySQL users password', None)
    parser.addini('mysql_database_name', 'The MySQL database name', None, 'brahma_test')


def _run_sql_script(script_path, config):
    old_cwd = os.getcwd()
    os.chdir(script_path.parent)

    command = ' '.join([
        'mysql',
        '--user', config.getini('mysql_user'),
        f'-p"{config.getini("mysql_password")}"',
        '--host', config.getini('mysql_host'),
        config.getini('mysql_database_name'),
        '<', str(script_path),
        '2>&1',
        '| findstr /V /C:"password on the command line interface can be insecure"',
        '1>&2',
    ])

    os.system(command)

    os.chdir(old_cwd)


@pytest.fixture(scope='session')
def db_connection(request):
    config = request.config

    connection = mysql.connector.connect(
        host=config.getini('mysql_host'),
        user=config.getini('mysql_user'),
        passwd=config.getini('mysql_password'))

    database_name = config.getini('mysql_database_name')
    with connection.cursor() as cursor:
        cursor.execute(f'drop database if exists {database_name}')
        cursor.execute(f'create database {database_name} character set utf8mb4 collate utf8mb4_unicode_ci')

    _run_sql_script(brahma_sql, config)

    connection.database = database_name

    yield connection
    connection.close()


@pytest.fixture(scope='function')
def db_cursor(db_connection):
    cursor = db_connection.cursor()
    yield cursor
    cursor.close()
