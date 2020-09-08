#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

delimiter //

# summary:
# Calculates the ratio between the specified count and the specified current.
#
# params:
# - $count: The count.
# - $current_micro: The current in µA.
# - $runtime: The runtime in seconds.
# - $electrical_charge: The electrical charge of the ions measured as current.
#
# returns:
# The ratio or null if the current or the runtime is zero.
create function count_by_current_ratio($count int, $current_micro double, $runtime double, $electrical_charge double)
returns double deterministic
begin
    declare $elementary_charge double default 1.60217662e-19;
    return safe_ratio(
        $count * 1e6 * $electrical_charge * $elementary_charge,
        $current_micro * $runtime);
end;

//
delimiter ;
