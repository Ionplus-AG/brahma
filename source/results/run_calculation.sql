#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

delimiter //

create procedure calculate_run($run_id int)
begin_main:
begin
    declare $enabled_cycles int;
    declare $total_cycles int;

    declare $runtime double;
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

    declare $ratio_a_ana double;
    declare $ratio_a_ana_sum double;
    declare $ratio_a_ana_sum2 double;
    declare $ratio_a_ana_sigma double;

    declare $weight_sum double;

    calc_data:
    begin
        # calculate sums
        select if((min(runtime) > 0), sum(runtime), null),
               if((min(runtime) < 0) || (min(a * runtime) < 0), null, sum(a * runtime)),
               count(*),
               if((min(r) < 0) || (count(r) != count(*)), null, sum(r)),
               if((min(g1) < 0) || (count(g1) != count(*)), null, sum(g1)),
               if((min(g2) < 0) || (count(g2) != count(*)), null, sum(g2))
        into $runtime, $weight_sum, $enabled_cycles, $r, $g1, $g2
        from cycle where run_id = $run_id and disabled is false;

        select count(*)
        into $total_cycles
        from cycle where run_id = $run_id;

        select end_of_cycle
        into $end_of_last_cycle
        from cycle
        where run_id = $run_id and disabled is false
        order by end_of_cycle desc
        limit 1;

        # condition runtime != null, runtime > 0, cycles > 0
        if ($runtime is null) || ($enabled_cycles < 1) then
            set $r = null;
            set $g1 = null;
            set $g2 = null;
            set $runtime = null;
            set $enabled_cycles = null;
            leave calc_data;
        end if;

        # calculates means
        # for the currents, the weight is the runtime,
        # for the ratios the weight is a*runtime.
        # the sum of the weight is calculated some lines above
        select if(count(ana) != $enabled_cycles, null, sum(ana * runtime) / $runtime),
               if(count(a) != $enabled_cycles, null, sum(a * runtime) / $runtime),
               if(count(b) != $enabled_cycles, null, sum(b * runtime) / $runtime),
               if(count(c) != $enabled_cycles, null, sum(c * runtime) / $runtime)
        into $ana, $a, $b, $c
        from cycle where run_id = $run_id and disabled is false;

        select if((min(ratio_r_a) < 0) || (count(ratio_r_a) != $enabled_cycles), null,
                  sum(ratio_r_a * a * runtime) / $weight_sum),
               if((min(ratio_r_a) < 0) || (count(ratio_r_a) != $enabled_cycles), null, sum(ratio_r_a * a * runtime)),
               if((min(ratio_r_a) < 0) || (count(ratio_r_a) != $enabled_cycles), null,
                  sum(ratio_r_a * ratio_r_a * a * runtime))
        into $ratio_r_a, $ratio_r_a_sum, $ratio_r_a_sum2
        from cycle where run_id = $run_id and disabled is false;

        select if((min(ratio_r_b) < 0) || (count(ratio_r_b) != $enabled_cycles), null,
                  sum(ratio_r_b * a * runtime) / $weight_sum),
               if((min(ratio_r_b) < 0) || (count(ratio_r_b) != $enabled_cycles), null, sum(ratio_r_b * a * runtime)),
               if((min(ratio_r_b) < 0) || (count(ratio_r_b) != $enabled_cycles), null,
                  sum(ratio_r_b * ratio_r_b * a * runtime))
        into $ratio_r_b, $ratio_r_b_sum, $ratio_r_b_sum2
        from cycle where run_id = $run_id and disabled is false;

        select if((min(ratio_g1_a) < 0) || (count(ratio_g1_a) != $enabled_cycles), null,
                  sum(ratio_g1_a * a * runtime) / $weight_sum),
               if((min(ratio_g1_b) < 0) || (count(ratio_g1_b) != $enabled_cycles), null,
                  sum(ratio_g1_b * a * runtime) / $weight_sum)
        into $ratio_g1_a, $ratio_g1_b
        from cycle where run_id = $run_id and disabled is false;

        select if((min(ratio_g2_a) < 0) || (count(ratio_g2_a) != $enabled_cycles), null,
                  sum(ratio_g2_a * a * runtime) / $weight_sum),
               if((min(ratio_g2_b) < 0) || (count(ratio_g2_b) != $enabled_cycles), null,
                  sum(ratio_g2_b * a * runtime) / $weight_sum)
        into $ratio_g2_a, $ratio_g2_b
        from cycle where run_id = $run_id and disabled is false;

        select if((min(ratio_b_a) < 0) || (count(ratio_b_a) != $enabled_cycles), null,
                  sum(ratio_b_a * a * runtime) / $weight_sum),
               if((min(ratio_b_a) < 0) || (count(ratio_b_a) != $enabled_cycles), null, sum(ratio_b_a * a * runtime)),
               if((min(ratio_b_a) < 0) || (count(ratio_b_a) != $enabled_cycles), null,
                  sum(ratio_b_a * ratio_b_a * a * runtime))
        into $ratio_b_a, $ratio_b_a_sum, $ratio_b_a_sum2
        from cycle where run_id = $run_id and disabled is false;

        select if((min(ratio_a_ana) < 0) || (count(ratio_a_ana) != $enabled_cycles), null,
                  sum(ratio_a_ana * a * runtime) / $weight_sum),
               if((min(ratio_a_ana) < 0) || (count(ratio_a_ana) != $enabled_cycles), null,
                  sum(ratio_a_ana * a * runtime)),
               if((min(ratio_a_ana) < 0) || (count(ratio_a_ana) != $enabled_cycles), null,
                  sum(ratio_a_ana * ratio_a_ana * a * runtime))
        into $ratio_a_ana, $ratio_a_ana_sum, $ratio_a_ana_sum2
        from cycle where run_id = $run_id and disabled is false;

        # calculate errors
        if $r > 0 then
            set $r_delta = 100 / sqrt($r);
        elseif $r = 0 then
            set $r_delta = 100;
        else
            set $r_delta = null;
        end if;

        if $g1 > 0 then
            set $g1_delta = 100 / sqrt($g1);
        elseif $g1 = 0 then
            set $g1_delta = 100;
        else
            set $g1_delta = null;
        end if;

        if $g2 > 0 then
            set $g2_delta = 100 / sqrt($g2);
        elseif $g2 = 0 then
            set $g2_delta = 100;
        else
            set $g2_delta = null;
        end if;

        # condition: 0 <= r, r != null, 0 <= ra,
        select if($r is not null, pow(sum(r / (ratio_r_a * ratio_r_a)), -0.5) / $ratio_r_a, null),
               if($r is not null, pow(sum(r / (ratio_r_b * ratio_r_b)), -0.5) / $ratio_r_b, null),
               pow(sum(1 / (ratio_b_a * ratio_b_a)), -0.5) / $ratio_b_a
        into $ratio_r_a_delta, $ratio_r_b_delta, $ratio_b_a_delta
        from cycle where run_id = $run_id and disabled is false;

        # calculate sigmas (enhanced error handling to prevent division by 0)
        if ($weight_sum <= 0) || ($weight_sum * ($enabled_cycles - 1) <= 0) || ($ratio_r_a <= 0) then
            set $ratio_r_a_sigma = null;
            leave calc_data;
        end if;
        set $ratio_r_a_sigma = sqrt(($ratio_r_a_sum2 - (pow($ratio_r_a_sum, 2) / $weight_sum)) / ($weight_sum * ($enabled_cycles - 1))) / $ratio_r_a * 100;

        if ($weight_sum <= 0) || ($weight_sum * ($enabled_cycles - 1) <= 0) || ($ratio_r_b <= 0) then
            set $ratio_r_b_sigma = null;
            leave calc_data;
        end if;
        set $ratio_r_b_sigma = sqrt(($ratio_r_b_sum2 - (pow($ratio_r_b_sum, 2) / $weight_sum)) / ($weight_sum * ($enabled_cycles - 1))) / $ratio_r_b * 100;

        if ($weight_sum <= 0) || ($weight_sum * ($enabled_cycles - 1) <= 0) || ($ratio_b_a <= 0) then
            set $ratio_b_a_sigma = null;
            leave calc_data;
        end if;
        set $ratio_b_a_sigma = sqrt(($ratio_b_a_sum2 - (pow($ratio_b_a_sum, 2) / $weight_sum)) / ($weight_sum * ($enabled_cycles - 1))) / $ratio_b_a * 100;

        if ($weight_sum <= 0) || ($weight_sum * ($enabled_cycles - 1) <= 0) || ($ratio_a_ana <= 0) then
            set $ratio_a_ana_sigma = null;
            leave calc_data;
        end if;
        set $ratio_a_ana_sigma = sqrt(($ratio_a_ana_sum2 - (pow($ratio_a_ana_sum, 2) / $weight_sum)) / ($weight_sum * ($enabled_cycles - 1))) / $ratio_a_ana * 100;
    end; -- calc_data

    store_data:
    begin
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
            ratio_a_ana = $ratio_a_ana,
            ratio_a_ana_sigma = $ratio_a_ana_sigma
        where id = $run_id;
    end; -- store_data
end //

//
delimiter ;
