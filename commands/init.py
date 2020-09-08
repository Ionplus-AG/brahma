#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import click
import database
import database.schema

from commands import common


@click.command()
@click.option('--rebuild', is_flag=True, help='drops and rebuilds existing brahma instance')
@common.database_options
@click.argument('schema_name')
def init(schema_name, rebuild, **kwargs):
    """Initialize the brahma database schema.

    \b
    SCHEMA_NAME: the name for the brahma database schema
    """
    click.echo('')
    with database.Session(**kwargs) as session:
        brahma = database.Brahma(schema_name, session)

        if brahma.exists:
            if rebuild:
                click.echo(f'Warning: The schema {schema_name} already exist => going to drop it', err=True)
                brahma.drop()
            else:
                click.echo(f'The schema {schema_name} already exist => nothing to do')
                return

        click.echo(f'Initializing brahma into {schema_name}')
        brahma.create()
        click.echo('done')
