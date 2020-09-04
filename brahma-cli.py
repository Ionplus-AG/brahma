#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import click
import database


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
    """Initialize the brahma database schema

    SCHEMA_NAME: the name for the brahma database schema
    """
    click.echo('')
    with database.Session(**kwargs) as db_session:
        brahma = database.Brahma(schema_name, db_session)

        if brahma.exists:
            if rebuild:
                click.echo(f'Warning: The schema {schema_name} already exist => going to drop it')
                brahma.drop()
            else:
                click.echo(f'The schema {schema_name} already exist => nothing to do')
                return

        click.echo(f'Initializing brahma into {schema_name}')
        brahma.create()
        click.echo('done')


@click.command()
@common_options
def migrate():
    click.echo('migrate called')


cli.add_command(init)
cli.add_command(migrate)


if __name__ == '__main__':
    cli()
