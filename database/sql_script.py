#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import os


def _grep_command(not_matching):
    if os.name == 'nt':
        return f'findstr /V /C:"{not_matching}"'

    return f'grep -v "{not_matching}"'


def run(script_path, host, user, password, schema_name):
    old_cwd = os.getcwd()
    os.chdir(script_path.parent)

    command = ' '.join([
        'mysql',
        '--user', user,
        f'-p"{password}"',
        '--host', host,
        schema_name,
        '<', str(script_path),
        '2>&1',
        '|',
        _grep_command('password on the command line interface can be insecure'),
        '1>&2',
    ])

    os.system(command)

    os.chdir(old_cwd)
