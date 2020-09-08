#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import sys

import click
import database
import database.schema

from commands import common
from legacy import Generator


@click.command()
@common.database_options
@click.argument('source')
@click.argument('target')
@click.option('--isotope', default=3, show_default=True, help='the isotope number')
@click.argument('machine_number')
def legacy(source, target, machine_number, isotope, **kwargs):
    """Generate views for legacy tool onto brahma.

    \b
    SOURCE: the name of the brahma database to generate the views for
    TARGET: the name of the legacy-view database
    MACHINE_NUMBER: the number of the machine the views are for
    """
    click.echo('')
    with database.Session(**kwargs) as session:
        if not database.schema.exists(source, session):
            click.echo(f'Error: Source database {source} not found!\n', err=True)
            click.echo('Check the spelling an try again.')
            sys.exit(1)

        if database.schema.exists(target, session):
            click.echo(f'Warning: The schema {target} already exist => going to drop it', err=True)
            database.schema.drop(target, session)

        database.schema.create(target, session)

        generator = Generator(session, source, target, machine_number, isotope)
        generator.run()
