#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import sys

import click
import database
import database.schema
import migration

from commands import common


@click.command('migrate_ams')
@click.argument('source')
@click.argument('target')
@click.option('--isotope', default=3, show_default=True, help='the isotope number')
@common.database_options
def ams(source, target, isotope, **kwargs):
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


@click.command('migrate_ac14')
@click.argument('source')
@click.argument('target')
@click.argument('machine_number')
@click.option('--isotope', default=3, show_default=True, help='the isotope number')
@click.option('--skip-calc', is_flag=True, help='skip the calculation of the runs/targets')
@common.database_options
def ac14(source, target, machine_number, isotope, skip_calc, **kwargs):
    """Migrate an ac14 database into brahma.

    \b
    SOURCE: the name of the ac14 database to migrate from
    TARGET: the name of the brahma database to migrate to
    MACHINE_NUMBER: the number of the machine to migrate. The machine must exist in TARGET!
    """
    click.echo('')
    with database.Session(**kwargs) as session:
        _validate(source, target, session)
        _validate_machine_exists(machine_number, target, session)

        click.echo(f'Migrating {source} into {target}')
        migrator = migration.Ac14Migrator(session, source, target, isotope, machine_number)

        _migrate('run', migrator.migrate_run)

        click.echo('  adding cycle_definition:', nl=False)
        cycle_definition_id = migrator.add_default_cycle_definition()
        click.echo(' done')

        _migrate('cycle', migrator.migrate_cycle, cycle_definition_id)

        if not skip_calc:
            _perform('calculating', 'runs', migrator.calculate_runs)
            _perform('calculating', 'targets', migrator.calculate_targets)

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


def _validate_machine_exists(machine_number, target, session):
    query = 'select number from _brahma_.machine where machine.number = %(machine_number)s'.\
        replace('_brahma_', target)

    with session.cursor() as cursor:
        cursor.execute(query, {'machine_number': machine_number})
        if not bool(cursor.fetchall()):
            click.echo(f'Error: No machine with number {machine_number} found in database {target}\n')
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
