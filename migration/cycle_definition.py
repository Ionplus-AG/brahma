#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

class CycleDefinition(object):
    def __init__(self, isotope_number, machine_number, **kwargs):
        self.isotope_number = isotope_number
        self.machine_number = machine_number

        self.sequence = kwargs.get('sequence', 0)
        self.electrical_charge = kwargs.get('electrical_charge', 1)

        self.name = kwargs.get('name', None)

        self.r_name = kwargs.get('r_name', None)
        self.g1_name = kwargs.get('g1_name', None)
        self.g2_name = kwargs.get('g2_name', None)

        self.ana_name = kwargs.get('ana_name', None)
        self.a_name = kwargs.get('a_name', None)
        self.b_name = kwargs.get('b_name', None)
        self.c_name = kwargs.get('c_name', None)

    @property
    def params(self):
        return [
            self.isotope_number, self.machine_number, self.sequence, self.electrical_charge, self.name,
            self.r_name, self.g1_name, self.g2_name, self.ana_name, self.a_name, self.b_name, self.c_name
        ]


default = {
    1: lambda machine_number:
    CycleDefinition(3, machine_number, name='^{26}Al', r_name='^{26}Al', ana_name='^{27}Al-LE',
                    a_name='^{27}Al', b_name=None, c_name=None),

    2: lambda machine_number:
    CycleDefinition(3, machine_number, name='^{10}Be', r_name='^{10}Be', ana_name='^{9}BeO-LE',
                    a_name='^{9}Be', b_name=None, c_name=None),

    3: lambda machine_number:
    CycleDefinition(3, machine_number, name='^{14}C', r_name='^{14}C', ana_name='^{12}C-LE',
                    a_name='^{12}C', b_name='^{13}C', c_name='^{13}CH'),

    4: lambda machine_number:
    CycleDefinition(3, machine_number, name='^{41}Ca', r_name='^{41}Ca', ana_name=None,
                    a_name=None, b_name=None, c_name=None),

    5: lambda machine_number:
    CycleDefinition(3, machine_number, name='^{129}I', r_name='^{129}I', ana_name='^{127}I-LE',
                    a_name='^{127}I', b_name=None, c_name=None),

    6: lambda machine_number:
    CycleDefinition(3, machine_number, name='Pu', r_name=None, ana_name=None,
                    a_name=None, b_name=None, c_name=None),

    7: lambda machine_number:
    CycleDefinition(3, machine_number, name='^{32}Si', r_name='^{32}Si', ana_name=None,
                    a_name=None, b_name=None, c_name=None),

    8: lambda machine_number:
    CycleDefinition(3, machine_number, name='U', r_name=None, ana_name=None,
                    a_name=None, b_name=None, c_name=None),
}
