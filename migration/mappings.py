#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

from migration.table_mapping import TableMapping

customer = TableMapping('user_t', 'customer', (
    ('user_nr', 'number'),
    ('first_name',),
    ('last_name',),
    ('organisation',),
    ('institute',),
    ('address_1',),
    ('address_2',),
    ('town',),
    ('postcode',),
    ('country',),
    ('phone_1',),
    ('phone_2',),
    ('fax',),
    ('email',),
    ('www',),
    ('account',),
    ('invoice', 'is_invoice'),
    ('correspondance', 'is_correspondence'),
    ('user_comment', 'comment'),
    ('language',),
    ('title',),
    ('salutation',),
))

project = TableMapping('project_t', 'project', (
    ('project_nr', 'number'),
    ('project', 'name'),
    ('advisor',),
    ('user_nr', 'customer_number'),
    ('invoice_nr', 'invoice_customer_number'),
    ('in_date',),
    ('out_date',),
    ('desired_date',),
    ('priority',),
    ('report_type',),
    ('letter',),
    ('project_comment', 'comment'),
    ('status',),
    ('price',),
    ('project_type', 'type'),
    ('research', 'research_type'),
    ('invoice',),
    ('invoice_date',),
))


def isotope_number(number):
    return number, 'isotope_number'


sample = TableMapping('sample_t', 'sample', (
    ('sample_nr', 'number'),
    ('project_nr', 'project_number'),
    ('photo',),
    ('type',),
    ('material',),
    ('fraction',),
    ('pre_sub_treat',),
    ('weight',),
    ('preparation',),
    ('sampling_date',),
    ('editable',),
    ('not_tobedated', 'not_to_be_dated'),
    ('user_label',),
    ('user_label_nr', 'user_label_number'),
    ('user_desc1', 'user_description1'),
    ('user_desc2', 'user_description2'),
    ('residue',),
    ('c14_age',),
    ('c14_age_sig', 'c14_age_sigma'),
    ('av_fm',),
    ('av_fm_sig', 'av_fm_sigma'),
    ('av_dc13',),
    ('av_dc13_sig', 'av_dc13_sigma'),
    ('av_dc13_irms',),
    ('cal1sMin', 'cal1s_min'),
    ('cal1sMax', 'cal1s_max'),
    ('cal2sMin', 'cal2s_min'),
    ('cal2sMax', 'cal2s_max'),
    ('cal_curve',),
    ('delta_R', 'delta_r'),
    ('calib', 'calibration'),
    ('old_info',),
    ('user_comment',),
))

preparation = TableMapping('preparation_t', 'preparation', (
    ('sample_nr', 'sample_number'),
    ('prep_nr', 'number'),
    ('batch',),
    ('prep_comment', 'comment'),
    ('weight_start',),
    ('weight_medium',),
    ('weight_end',),
    ('step1_method',),
    ('step1_start',),
    ('step1_end',),
    ('step2_method',),
    ('step2_start',),
    ('step2_end',),
    ('step3_method',),
    ('step3_start',),
    ('step3_end',),
    ('step4_method',),
    ('step4_start',),
    ('step4_end',),

    # step 5 isn't mapped as it doesn't exist anymore
    # ('step5_method',),
    # ('step5_start',),
    # ('step5_end',),

    ('cn_ratio',),
    ('c_percent',),
    ('n_percent',),
    ('prep_end', 'end'),
    ('stop',),
    ('old_info',),
))

target = TableMapping('target_t', 'target', (
    ('sample_nr', 'sample_number'),
    ('prep_nr', 'preparation_number'),
    ('target_nr', 'number'),
    # ('magazine',), will be mapped in a later step
    ('position', 'magazine_position'),
    # ('precis',), not mapped
    # ('cycle_min',), not mapped
    ('cycle_max',),
    # ('combustion',), not mapped
    # ('catalyst',), not mapped
    # ('cathode_nr',), not mapped
    ('reactor_nr', 'reactor_number'),
    ('co2_init',),
    ('co2_final',),
    ('hydro_init',),
    ('hydro_final',),
    ('react_time',),
    ('target_comment', 'comment'),
    ('target_pressed', 'pressed'),
    ('stop',),
    ('old_info',),
    ('meas_comment', 'measurement_comment'),
    ('fm',),
    ('fm_sig', 'fm_sigma'),
    ('dc13',),
    ('dc13_sig', 'dc13_sigma'),
    ('calcset',),
    ('editallowed', 'edit_allowed'),
    ('c14_age',),
    ('c14_age_sig', 'c14_age_sigma'),
    ('cal1sMin', 'cal1s_min'),
    ('cal1sMax', 'cal1s_max'),
    ('cal2sMin', 'cal2s_min'),
    ('cal2sMax', 'cal2s_max'),
    ('weight',),
    ('conc_n',),
    ('graphitized',),
    ('temp', 'temperature'),
    ('conc_c',),
))
