#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#
import mysql.connector


# noinspection PyPep8Naming
def Session(**kwargs):
    return mysql.connector.connect(
        host=kwargs['host'],
        user=kwargs['user'],
        passwd=kwargs['password'])
