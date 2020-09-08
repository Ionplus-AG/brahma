#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

setCycleEnableNT = '''
create procedure _legacy_.setCycleEnableNT($state int, $run varchar(10), $cycle int)
main:
begin
    declare $cycle_id int;
    declare $run_id int;

    set $run_id = cast(regexp_replace($run, '[^0-9]', '') as signed);

    select cycle.id into $cycle_id
    from _brahma_.cycle
    inner join _brahma_.run on cycle.run_id = run.id
    where cycle.number = $cycle and run.id = $run_id;

    call _brahma_.set_cycle_enabled($cycle_id, $state);
end;
'''

setRunEnableNT = '''
create procedure _legacy_.setRunEnableNT($state int, $run varchar(10))
main:
begin
    declare $run_id int;

    set $run_id = cast(regexp_replace($run, '[^0-9]', '') as signed);

    call _brahma_.set_run_enabled($run_id, $state);
end;
'''
