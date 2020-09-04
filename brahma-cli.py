#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import sys

import click
import database
import database.schema
import migration


def common_options(function):
    function = click.option('--host', default='localhost', show_default=True, help='the database host')(function)
    function = click.option('--user', default='root', show_default=True, help='the database user')(function)
    function = click.option('-p', '--password',
                            prompt=True, hide_input=True, default='',
                            help='the database password')(function)
    return function


@click.group()
def cli():
    pass


@click.command()
@click.option('--rebuild', is_flag=True, help='drops and rebuilds existing brahma instance')
@common_options
@click.argument('schema_name')
def init(schema_name, rebuild, **kwargs):
    """Initialize the brahma database schema.

    SCHEMA_NAME: the name for the brahma database schema
    """
    click.echo('')
    with database.Session(**kwargs) as db_session:
        brahma = database.Brahma(schema_name, db_session)

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


def _validate(source, target, db_session):
    if not database.schema.exists(target, db_session):
        click.echo(f'Error: Target database {target} not found!\n')
        click.echo(f"Consider initializing it by calling 'brahma-cli init {target}'.", err=True)
        sys.exit(1)

    if not database.schema.exists(source, db_session):
        click.echo(f'Error: Source database {source} not found!\n', err=True)
        click.echo('Check the spelling an try again.')
        sys.exit(1)


def _migrate(name, function, *args):
    click.echo(f'  migrating {name}:', nl=False)
    result = function(*args)
    rows = 'rows'
    if result == 1:
        rows = 'row'
    click.echo(f' {result} {rows}')


@click.command()
@common_options
@click.argument('source')
@click.argument('target')
@click.option('--isotope', default=3, show_default=True, help='the isotope number to use for the migrated samples')
def migrate_ams(source, target, isotope, **kwargs):
    """Migrate an ams database into brahma.

    SOURCE: the name of the ams database to migrate from
    TARGET: the name of the brahma database to migrate to
    """
    click.echo('')
    with database.Session(**kwargs) as db_session:
        _validate(source, target, db_session)

        click.echo(f'Migrating {source} into {target}')
        session = migration.Session(db_session, target, source, '<unused>')

        _migrate('customer', session.migrate_customer)
        _migrate('project', session.migrate_project)

        _migrate('sample', session.migrate_sample, isotope)
        _migrate('preparation', session.migrate_preparation, isotope)
        _migrate('target', session.migrate_target, isotope)

        _migrate('magazine', session.migrate_magazine)

        click.echo('  associating targets to magazines:', nl=False)
        session.associate_magazine()
        click.echo(' done')

        _migrate('measurement_sequence', session.migrate_measurement_sequence)

    click.echo('done')


@click.command()
@common_options
@click.argument('source')
@click.argument('target')
def migrate_ac14(source, target, **kwargs):
    """Migrate an ac14 database into brahma.

    SOURCE: the name of the ac14 database to migrate from
    TARGET: the name of the brahma database to migrate to
    """
    click.echo('')
    with database.Session(**kwargs) as db_session:
        _validate(source, target, db_session)


cli.add_command(init)
cli.add_command(migrate_ams)
cli.add_command(migrate_ac14)


if __name__ == '__main__':
    cli()
