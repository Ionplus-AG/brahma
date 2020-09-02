#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

delimiter //

# summary:
# Calculates the sums and errors of all enabled cycles of the specified run.
#
# params:
# - $run_id: The identifier of the run.
create procedure calculate_run($run_id int)
begin
    declare $enabled_cycles int default 0;
    declare $valid_enabled_cycles int default 0;
    declare $total_cycles int default 0;

    declare $runtime double default 0;
    declare $end_of_last_cycle datetime(3);

    declare $r int;
    declare $r_delta double;

    declare $g1 int;
    declare $g1_delta double;

    declare $g2 int;
    declare $g2_delta double;

    declare $ana double;
    declare $a double;
    declare $b double;
    declare $c double;

    declare $ratio_g1_a double;
    declare $ratio_g1_b double;
    declare $ratio_g2_a double;
    declare $ratio_g2_b double;

    declare $ratio_r_a double;
    declare $ratio_r_a_sum double;
    declare $ratio_r_a_sum2 double;
    declare $ratio_r_a_delta double;
    declare $ratio_r_a_sigma double;

    declare $ratio_r_b double;
    declare $ratio_r_b_sum double;
    declare $ratio_r_b_sum2 double;
    declare $ratio_r_b_delta double;
    declare $ratio_r_b_sigma double;

    declare $ratio_b_a double;
    declare $ratio_b_a_sum double;
    declare $ratio_b_a_sum2 double;
    declare $ratio_b_a_delta double;
    declare $ratio_b_a_sigma double;

    declare $transmission double;
    declare $transmission_sum double;
    declare $transmission_sum2 double;
    declare $transmission_sigma double;

    declare $weight_sum double;

    calculate:
    begin
        # check if there is something to do
        select count(*)
        into $enabled_cycles
        from cycle where run_id = $run_id and enabled is true;

        select count(*)
        into $valid_enabled_cycles
        from cycle where run_id = $run_id and enabled is true and valid is true;

        if $enabled_cycles < 1 || $enabled_cycles != $valid_enabled_cycles then
            leave calculate;
        end if;

        # calculate the sums
        select sum(runtime),
               if(count(a) = $enabled_cycles, sum(a * runtime), null),
               if(count(r) = $enabled_cycles, sum(r), null),
               if(count(g1) = $enabled_cycles, sum(g1), null),
               if(count(g2) = $enabled_cycles, sum(g2), null)
        into $runtime, $weight_sum, $r, $g1, $g2
        from cycle where run_id = $run_id and enabled is true;

        select count(*)
        into $total_cycles
        from cycle where run_id = $run_id;

        select end_of_cycle
        into $end_of_last_cycle
        from cycle
        where run_id = $run_id and enabled is true
        order by end_of_cycle desc
        limit 1;

        # calculate the means
        # for the currents, the weight is the runtime,
        # for the ratios the weight is a*runtime (aka weight_sum).
        set $a = $weight_sum / $runtime;
        select if(count(ana) = $enabled_cycles, sum(ana * runtime) / $runtime, null),
               if(count(b) = $enabled_cycles, sum(b * runtime) / $runtime, null),
               if(count(c) = $enabled_cycles, sum(c * runtime) / $runtime, null)
        into $ana, $b, $c
        from cycle where run_id = $run_id and enabled is true;

        if $weight_sum > 0 then

            select if(count(ratio_r_a) = $enabled_cycles, sum(ratio_r_a * a * runtime) / $weight_sum, null),
                   if(count(ratio_r_a) = $enabled_cycles, sum(ratio_r_a * a * runtime), null),
                   if(count(ratio_r_a) = $enabled_cycles, sum(ratio_r_a * ratio_r_a * a * runtime), null)
            into $ratio_r_a, $ratio_r_a_sum, $ratio_r_a_sum2
            from cycle where run_id = $run_id and enabled is true;

            select if(count(ratio_r_b) = $enabled_cycles, sum(ratio_r_b * a * runtime) / $weight_sum, null),
                   if(count(ratio_r_b) = $enabled_cycles, sum(ratio_r_b * a * runtime), null),
                   if(count(ratio_r_b) = $enabled_cycles, sum(ratio_r_b * ratio_r_b * a * runtime), null)
            into $ratio_r_b, $ratio_r_b_sum, $ratio_r_b_sum2
            from cycle where run_id = $run_id and enabled is true;

            select if(count(ratio_g1_a) = $enabled_cycles, sum(ratio_g1_a * a * runtime) / $weight_sum, null),
                   if(count(ratio_g1_b) = $enabled_cycles, sum(ratio_g1_b * a * runtime) / $weight_sum, null)
            into $ratio_g1_a, $ratio_g1_b
            from cycle where run_id = $run_id and enabled is true;

            select if(count(ratio_g2_a) = $enabled_cycles, sum(ratio_g2_a * a * runtime) / $weight_sum, null),
                   if(count(ratio_g2_b) = $enabled_cycles, sum(ratio_g2_b * a * runtime) / $weight_sum, null)
            into $ratio_g2_a, $ratio_g2_b
            from cycle where run_id = $run_id and enabled is true;

            select if(count(ratio_b_a) = $enabled_cycles, sum(ratio_b_a * a * runtime) / $weight_sum, null),
                   if(count(ratio_b_a) = $enabled_cycles, sum(ratio_b_a * a * runtime), null),
                   if(count(ratio_b_a) = $enabled_cycles, sum(ratio_b_a * ratio_b_a * a * runtime), null)
            into $ratio_b_a, $ratio_b_a_sum, $ratio_b_a_sum2
            from cycle where run_id = $run_id and enabled is true;

            select if(count(transmission) = $enabled_cycles, sum(transmission * a * runtime) / $weight_sum, null),
                   if(count(transmission) = $enabled_cycles, sum(transmission * a * runtime), null),
                   if(count(transmission) = $enabled_cycles, sum(transmission * transmission * a * runtime), null)
            into $transmission, $transmission_sum, $transmission_sum2
            from cycle where run_id = $run_id and enabled is true;

            # calculate the errors
            if $r > 0 then
                set $r_delta = 100 / sqrt($r); # TODO, 2020-09-01, ewc: WTF?
            elseif $r = 0 then
                set $r_delta = 100;
            else
                set $r_delta = null;
            end if;

            if $g1 > 0 then
                set $g1_delta = 100 / sqrt($g1); # TODO, 2020-09-01, ewc: WTF?
            elseif $g1 = 0 then
                set $g1_delta = 100;
            else
                set $g1_delta = null;
            end if;

            if $g2 > 0 then
                set $g2_delta = 100 / sqrt($g2); # TODO, 2020-09-01, ewc: WTF?
            elseif $g2 = 0 then
                set $g2_delta = 100;
            else
                set $g2_delta = null;
            end if;

            select if($r >= 0 && $ratio_r_a > 0, pow(sum(r / (ratio_r_a * ratio_r_a)), -0.5) / $ratio_r_a, null),
                   if($r >= 0 && $ratio_r_b > 0, pow(sum(r / (ratio_r_b * ratio_r_b)), -0.5) / $ratio_r_b, null),
                   if($ratio_b_a > 0, pow(sum(1 / (ratio_b_a * ratio_b_a)), -0.5) / $ratio_b_a, null)
            into $ratio_r_a_delta, $ratio_r_b_delta, $ratio_b_a_delta
            from cycle where run_id = $run_id and enabled is true;

            # calculate the sigmas, but only of there are at least 2 cycles
            if $enabled_cycles >= 2 then

                if $ratio_r_a > 0 then
                    set $ratio_r_a_sigma = sqrt(
                            ($ratio_r_a_sum2 - (pow($ratio_r_a_sum, 2) / $weight_sum)) / ($weight_sum * ($enabled_cycles - 1))
                        ) / $ratio_r_a * 100;
                end if;

                if $ratio_r_b > 0 then
                    set $ratio_r_b_sigma = sqrt(
                            ($ratio_r_b_sum2 - (pow($ratio_r_b_sum, 2) / $weight_sum)) / ($weight_sum * ($enabled_cycles - 1))
                        ) / $ratio_r_b * 100;
                end if;

                if $ratio_b_a > 0 then
                    set $ratio_b_a_sigma = sqrt(
                        ($ratio_b_a_sum2 - (pow($ratio_b_a_sum, 2) / $weight_sum)) / ($weight_sum * ($enabled_cycles - 1))
                    ) / $ratio_b_a * 100;
                end if;

                if $transmission > 0 then
                    set $transmission_sigma = sqrt(
                        ($transmission_sum2 - (pow($transmission_sum, 2) / $weight_sum)) / ($weight_sum * ($enabled_cycles - 1))
                    ) / $transmission * 100;
                end if;

            end if; -- $enabled_cycles >= 2

        end if; -- $weight_sum > 0
    end; -- calculate

    update run
    set enabled_cycles = $enabled_cycles,
        total_cycles = $total_cycles,
        runtime = $runtime,
        end_of_last_cycle = $end_of_last_cycle,
        r = $r,
        r_delta = $r_delta,
        g1 = $g1,
        g1_delta = $g1_delta,
        g2 = $g2,
        g2_delta = $g2_delta,
        a = $a,
        b = $b,
        ana = $ana,
        c = $c,
        ratio_r_a = $ratio_r_a,
        ratio_r_a_delta = $ratio_r_a_delta,
        ratio_r_a_sigma = $ratio_r_a_sigma,
        ratio_r_b = $ratio_r_b,
        ratio_r_b_delta = $ratio_r_b_delta,
        ratio_r_b_sigma = $ratio_r_b_sigma,
        ratio_g1_a = $ratio_g1_a,
        ratio_g1_b = $ratio_g1_b,
        ratio_g2_a = $ratio_g2_a,
        ratio_g2_b = $ratio_g2_b,
        ratio_b_a = $ratio_b_a,
        ratio_b_a_delta = $ratio_b_a_delta,
        ratio_b_a_sigma = $ratio_b_a_sigma,
        transmission = $transmission,
        transmission_sigma = $transmission_sigma
    where id = $run_id;

end;

//
delimiter ;
