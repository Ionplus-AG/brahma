#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import click


def common_options(function):
    function = click.option('--host', default='localhost', show_default=True, help='the database host')(function)
    function = click.option('--user', default='user', show_default=True, help='the database user')(function)
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
def init(schema_name, **kwargs):
    """Initialize the brahma database schema

    SCHEMA_NAME: the name for the brahma database schema
    """
    click.echo(f'init called, schema_name: {schema_name}, args: {kwargs}')


@click.command()
@common_options
def migrate():
    click.echo('migrate called')


cli.add_command(init)
cli.add_command(migrate)


if __name__ == '__main__':
    cli()
