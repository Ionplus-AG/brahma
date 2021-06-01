#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import click
import database
import database.schema

from commands import common
from seed import seed_defaults


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
