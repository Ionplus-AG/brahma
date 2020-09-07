#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import sys

import click
import database
import database.schema
import migration

from legacy import Generator as LegacyGenerator


def database_options(function):
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
@database_options
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


def _validate(source, target, session):
    if not database.schema.exists(target, session):
        click.echo(f'Error: Target database {target} not found!\n')
        click.echo(f"Consider initializing it by calling 'brahma-cli init {target}'.", err=True)
        sys.exit(1)

    if not database.schema.exists(source, session):
        click.echo(f'Error: Source database {source} not found!\n', err=True)
        click.echo('Check the spelling an try again.')
        sys.exit(1)


def _perform(action, name, function, *args):
    click.echo(f'  {action} {name}:', nl=False)
    result = function(*args)
    rows = 'rows'
    if result == 1:
        rows = 'row'
    click.echo(f' {result} {rows}')


def _migrate(name, function, *args):
    _perform('migrating', name, function, *args)


@click.command()
@database_options
@click.option('--isotope', default=3, show_default=True, help='the isotope number')
@click.argument('source')
@click.argument('target')
def migrate_ams(source, target, isotope, **kwargs):
    """Migrate an ams database into brahma.

    \b
    SOURCE: the name of the ams database to migrate from
    TARGET: the name of the brahma database to migrate to
    """
    click.echo('')
    with database.Session(**kwargs) as session:
        _validate(source, target, session)

        click.echo(f'Migrating {source} into {target}')
        migrator = migration.AmsMigrator(session, source, target, isotope)

        _migrate('customer', migrator.migrate_customer)
        _migrate('project_advisor', migrator.migrate_project_advisor)
        _migrate('project', migrator.migrate_project)

        _migrate('sample', migrator.migrate_sample)
        _migrate('preparation', migrator.migrate_preparation)
        _migrate('target', migrator.migrate_target)

        _migrate('magazine', migrator.migrate_magazine)

        click.echo('  associating targets to magazines:', nl=False)
        migrator.associate_magazine()
        click.echo(' done')

        _migrate('measurement_sequence', migrator.migrate_measurement_sequence)

        _migrate('calculation_set', migrator.migrate_calculation_set)
        _migrate('calculation_correction', migrator.migrate_calculation_correction)
        _migrate('calculation_sample', migrator.migrate_calculation_sample)

    click.echo('done')


@click.command()
@database_options
@click.argument('source')
@click.argument('target')
@click.option('--isotope', default=3, show_default=True, help='the isotope number')
@click.option('--skip-calc', is_flag=True, help='skip the calculation of the runs/targets')
@click.argument('machine_number')
def migrate_ac14(source, target, machine_number, isotope, skip_calc, **kwargs):
    """Migrate an ac14 database into brahma.

    \b
    SOURCE: the name of the ac14 database to migrate from
    TARGET: the name of the brahma database to migrate to
    MACHINE_NUMBER: the number of the machine to associate the runs to
    """
    click.echo('')
    with database.Session(**kwargs) as session:
        _validate(source, target, session)

        click.echo(f'Migrating {source} into {target}')
        migrator = migration.Ac14Migrator(session, source, target, isotope, machine_number)

        machine_number = int(machine_number)
        machine_prefix = f'M{machine_number:02d}'
        click.echo(f'  adding machine {machine_prefix}:', nl=False)
        migrator.add_machine(machine_prefix, machine_prefix)
        click.echo(' done')

        _migrate('run', migrator.migrate_run)

        click.echo(f'  adding cycle_definition:', nl=False)
        cycle_definition_id = migrator.add_default_cycle_definition()
        click.echo(' done')

        _migrate('cycle', migrator.migrate_cycle, cycle_definition_id)

        if not skip_calc:
            _perform('calculating', 'runs', migrator.calculate_runs)
            _perform('calculating', 'targets', migrator.calculate_targets)

    click.echo('done')


@click.command()
@database_options
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

        generator = LegacyGenerator(session, source, target, machine_number, isotope)
        generator.run()


cli.add_command(init)
cli.add_command(migrate_ams)
cli.add_command(migrate_ac14)
cli.add_command(legacy)


if __name__ == '__main__':
    cli()
