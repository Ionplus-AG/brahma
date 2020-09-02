#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

delimiter //

create procedure calculate_target($target_id int)
main:
begin
    declare $active_runs int default 0;
    declare $total_runs int default 0;

    declare $runtime double default 0;

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

    calculate:
    begin
        # check if there is something to do
        select count(*)
        into $active_runs
        from run where target_id = $target_id and active is true;

        if $active_runs < 1 then
            leave calculate;
        end if;

        # calculate the sums
        select sum(runtime),
               if(count(a) = $active_runs, sum(a * runtime), null),
               if(count(r) = $active_runs, sum(r), null),
               if(count(g1) = $active_runs, sum(g1), null),
               if(count(g2) = $active_runs, sum(g2), null)
        into $runtime, $weight_sum, $r, $g1, $g2
        from run where target_id = $target_id and disabled is false;

        select count(*)
        into $total_runs
        from run where target_id = $target_id;

        # calculate the means
        # for the currents, the weight is the runtime,
        # for the ratios the weight is a*runtime (aka weight_sum).
        set $a = $weight_sum / $runtime;
        select if(count(ana) = $active_runs, sum(ana * runtime) / $runtime, null),
               if(count(b) = $active_runs, sum(b * runtime) / $runtime, null),
               if(count(c) = $active_runs, sum(c * runtime) / $runtime, null)
        into $ana, $b, $c
        from run where target_id = $target_id and disabled is false;

        if $weight_sum > 0 then

            select if(count(ratio_r_a) = $active_runs, sum(ratio_r_a * a * runtime) / $weight_sum, null),
                   if(count(ratio_r_a) = $active_runs, sum(ratio_r_a * a * runtime), null),
                   if(count(ratio_r_a) = $active_runs, sum(ratio_r_a * ratio_r_a * a * runtime), null)
            into $ratio_r_a, $ratio_r_a_sum, $ratio_r_a_sum2
            from run where target_id = $target_id and disabled is false;

            select if(count(ratio_r_b) = $active_runs, sum(ratio_r_b * a * runtime) / $weight_sum, null),
                   if(count(ratio_r_b) = $active_runs, sum(ratio_r_b * a * runtime), null),
                   if(count(ratio_r_b) = $active_runs, sum(ratio_r_b * ratio_r_b * a * runtime), null)
            into $ratio_r_b, $ratio_r_b_sum, $ratio_r_b_sum2
            from run where target_id = $target_id and disabled is false;

            select if(count(ratio_g1_a) = $active_runs, sum(ratio_g1_a * a * runtime) / $weight_sum, null),
                   if(count(ratio_g1_b) = $active_runs, sum(ratio_g1_b * a * runtime) / $weight_sum, null)
            into $ratio_g1_a, $ratio_g1_b
            from run where target_id = $target_id and disabled is false;

            select if(count(ratio_g2_a) = $active_runs, sum(ratio_g2_a * a * runtime) / $weight_sum, null),
                   if(count(ratio_g2_b) = $active_runs, sum(ratio_g2_b * a * runtime) / $weight_sum, null)
            into $ratio_g2_a, $ratio_g2_b
            from run where target_id = $target_id and disabled is false;

            select if(count(ratio_b_a) = $active_runs, sum(ratio_b_a * a * runtime) / $weight_sum, null),
                   if(count(ratio_b_a) = $active_runs, sum(ratio_b_a * a * runtime), null),
                   if(count(ratio_b_a) = $active_runs, sum(ratio_b_a * ratio_b_a * a * runtime), null)
            into $ratio_b_a, $ratio_b_a_sum, $ratio_b_a_sum2
            from run where target_id = $target_id and disabled is false;

            select if(count(ratio_a_ana) = $active_runs, sum(ratio_a_ana * a * runtime) / $weight_sum, null),
                   if(count(ratio_a_ana) = $active_runs, sum(ratio_a_ana * a * runtime), null),
                   if(count(ratio_a_ana) = $active_runs, sum(ratio_a_ana * ratio_a_ana * a * runtime), null)
            into $ratio_a_ana, $ratio_a_ana_sum, $ratio_a_ana_sum2
            from run where target_id = $target_id and disabled is false;

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
            from run where target_id = $target_id and disabled is false;

            # calculate the sigmas, but only of there are at least 2 cycles
            if $active_runs >= 2 then

                if $ratio_r_a > 0 then
                    set $ratio_r_a_sigma = sqrt(
                            ($ratio_r_a_sum2 - (pow($ratio_r_a_sum, 2) / $weight_sum)) / ($weight_sum * ($active_runs - 1))
                        ) / $ratio_r_a * 100;
                end if;

                if $ratio_r_b > 0 then
                    set $ratio_r_b_sigma = sqrt(
                            ($ratio_r_b_sum2 - (pow($ratio_r_b_sum, 2) / $weight_sum)) / ($weight_sum * ($active_runs - 1))
                        ) / $ratio_r_b * 100;
                end if;

                if $ratio_b_a > 0 then
                    set $ratio_b_a_sigma = sqrt(
                        ($ratio_b_a_sum2 - (pow($ratio_b_a_sum, 2) / $weight_sum)) / ($weight_sum * ($active_runs - 1))
                    ) / $ratio_b_a * 100;
                end if;

                if $ratio_a_ana > 0 then
                    set $ratio_a_ana_sigma = sqrt(
                        ($ratio_a_ana_sum2 - (pow($ratio_a_ana_sum, 2) / $weight_sum)) / ($weight_sum * ($active_runs - 1))
                    ) / $ratio_a_ana * 100;
                end if;

            end if; -- $enabled_runs >= 2

        end if; -- $weight_sum > 0
    end; -- calculate

    update target
    set active_runs = $active_runs,
        total_runs = $total_runs,
        runtime = $runtime,
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
    where id = $target_id;
end -- main

//
delimiter ;
