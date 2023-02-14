stats_times_shot_by_arrow:
    type: world
    debug: false
    events:
        after arrow hits entity:living:
            - flag <context.hit_entity> stats.hit_by_projectile.arrow:0 if:<context.hit_entity.has_flag[stats.hit_by_projectile.arrow].not>
            - flag <context.hit_entity> stats.hit_by_projectile.arrow:+:1