#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import click
import database
import database.schema

from commands import common


@click.command()
@common.database_options
@click.argument('schema_name')
def seed(schema_name, **kwargs):
    """Seeds the brahma database data.

    \b
    SCHEMA_NAME: the name for the brahma database schema
    """
    click.echo('')
    with database.Session(**kwargs) as session:
        brahma = database.Brahma(schema_name, session)

        if brahma.exists:
            session.database = schema_name
            seed_defaults(session)
        else:
            click.echo(f'Seeding failed: \nThe schema {schema_name} does not exist.')
            return


def seed_defaults(session):
    with session.cursor() as cursor:
        seed_isotopes(cursor)
    session.commit()


isotopes = [
    (1, 'Al26', '^{26}Al'),
    (2, 'Be10', '^{10}Be'),
    (3, 'C14', '^{14}C'),
    (4, 'Ca41', '^{41}Ca'),
    (5, 'I129', '^{129}I'),
    (6, 'Pu', 'Pu'),
    (7, 'Si32', '^{32}Si'),
    (8, 'U', 'U')
]


def seed_isotopes(cursor):
    cursor.executemany("INSERT INTO isotope (number, name, name_markup) VALUES (%s, %s, %s)", isotopes)
