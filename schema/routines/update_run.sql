#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

delimiter //

# summary:
# Updates the specified run and its target.
#
# params:
# - $run_id: The identifier of the run to update.
create procedure update_run($run_id int)
begin
    declare $target_id int;

    call calculate_run($run_id);

    select target_id into $target_id
    from run where run.id = $run_id;

    call calculate_target($target_id);
end;

//
delimiter ;
