import os
import pathlib

import mysql.connector
import pytest


database_host = 'localhost'
database_user = 'root'
database_password = 'acsacs'
database_name = 'brahma_test'

brahma_sql = pathlib.Path(__file__).parent.parent.absolute() / 'source' / 'brahma.sql'


def run_sql_script(script_path):
    mysql_command = f'mysql --user {database_user} -p"{database_password}" --host {database_host} {database_name}'
    command = f'{mysql_command} < {script_path}'
    print(command)
    os.system(command)


@pytest.fixture(scope='session')
def db_connection():
    connection = mysql.connector.connect(
        host=database_host,
        user=database_user,
        passwd=database_password)

    with connection.cursor() as cursor:
        cursor.execute(f'drop database if exists {database_name}')
        cursor.execute(f'create database {database_name} character set utf8mb4 collate utf8mb4_unicode_ci')

    run_sql_script(brahma_sql)

    connection.database = database_name

    yield connection
    connection.close()


@pytest.fixture(scope='function')
def db_cursor(db_connection):
    cursor = db_connection.cursor()
    yield cursor
    cursor.close()
