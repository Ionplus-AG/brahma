#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

class TableMapping(object):
    def __init__(self, source, target, column_mappings=()):
        self.source = source
        self.target = target
        self.column_mappings = column_mappings

    def to_query(self, source_schema, target_schema, additional_mappings=()):
        return f'insert into {target_schema}.{self.target}{self.__target_columns(additional_mappings)}\n'\
               + f'select {self.__source_columns(additional_mappings)}\n'\
               + f'from {source_schema}.{self.source};'

    def __target_columns(self, additional_mappings):
        mappings = self.column_mappings + additional_mappings
        if not mappings:
            return ''

        target_columns = ', '.join(m[-1] for m in mappings)
        return f' ({target_columns})'

    def __source_columns(self, additional_mappings):
        mappings = self.column_mappings + additional_mappings
        if not mappings:
            return '*'

        return ', '.join(m[0] for m in mappings)
