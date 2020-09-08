#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

delimiter //

# summary:
# Calculates the division-by-zero-safe ratio of the specified values.
#
# params:
# - $dividend: The dividend.
# - $divisor: The divisor.
#
# returns:
# The ratio or, if the divisor is zero, null.
create function safe_ratio($dividend double, $divisor double)
returns double deterministic
begin
    declare $result double;

    if $divisor <> 0
    then
        set $result = $dividend / $divisor;
    end if;

    return $result;
end;

//
delimiter ;
