#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import sys

import click
import database
import database.schema
import validation

from commands import common


@click.command()
@click.argument('ams')
@click.argument('ac14')
@common.database_options
def validate(ams, ac14, **kwargs):
    """Validates the integrity of legacy databases.

    \b
    AMS: the name of the ams database schema
    AC14: the name of the ac14 database schema
    """
    pass
    click.echo('')
    with database.Session(**kwargs) as session:
        _validate_schema_exists(ams, session)
        _validate_schema_exists(ac14, session)

        validator = validation.Validator(session, ams, ac14)
        errors = list(validator.run())
        if not errors:
            click.echo('All well\n')
            return

        click.echo(f'{len(errors)} validation error{"s" if len(errors) != 1 else ""} found:')
        for error in errors:
            click.echo('- ' + error)

        click.echo('')


def _validate_schema_exists(schema, session):
    if not database.schema.exists(schema, session):
        click.echo(f'Error: Database {schema} not found!\n')
        sys.exit(1)
