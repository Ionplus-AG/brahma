#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import click
import commands.migrate


@click.group()
def cli():
    pass


cli.add_command(commands.init)
cli.add_command(commands.migrate.ams)
cli.add_command(commands.migrate.ac14)
cli.add_command(commands.legacy)


if __name__ == '__main__':
    cli()
