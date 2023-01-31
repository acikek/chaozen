climbing_chalk:
    type: item
    debug: false
    material: sugar
    allow in material recipes: false
    display name: <dark_aqua>Climbing Chalk
    lore:
    - <&7>Strengthens your grip.
    - <&7>Allows you to climb on fences, inner walls, buttons, chains, and iron bars.
    - <&7>Lasts 5 minutes.
    - <&7>Sneak + Right Click in air to apply.
    recipes:
        1:
            type: shapeless
            output_quantity: 4
            input: calcite

climbing_chalk_handler:
    type: world
    debug: false
    events:
        on player right clicks air with:climbing_chalk flagged:climbing_chalk_active:
        - ratelimit <player> 1t
        - if <player.flag_expiration[climbing_chalk_active].duration_since[<util.time_now>].is_more_than[30s]>:
            - narrate "<red>You have enough chalk for the moment."
            - stop
        - take iteminhand quantity:1
        - flag <player> climbing_chalk_active expire:<player.flag_expiration[climbing_chalk_active].add[5m]>
        - narrate "<aqua>You apply more chalk to your hands."
        - runlater climbing_chalk_low def:<player> delay:<player.flag_expiration[climbing_chalk_active].duration_since[<util.time_now>].sub[30s]>
        on player right clicks air with:climbing_chalk flagged:!climbing_chalk_active:
        - ratelimit <player> 1t
        - take iteminhand quantity:1
        - flag <player> climbing_chalk_active expire:5m
        - adjust <player> send_climbable_materials:<server.vanilla_tagged_materials[climbable].include[iron_bars|chain].include[<server.vanilla_tagged_materials[walls]>].include[<server.vanilla_tagged_materials[fences]>].include[<server.vanilla_tagged_materials[buttons]>]>
        - narrate "<aqua>You feel your grip strengthen."
        - runlater climbing_chalk_low def:<player> delay:270s
        on player quits flagged:climbing_chalk_active:
        - if <player.flag_expiration[climbing_chalk_active].duration_since[<util.time_now>].is_less_than[30s]>:
            - flag <player> climbing_chalk_active:!
            - stop
        - flag <player> climbing_chalk_offline_save:<player.flag_expiration[climbing_chalk_active].duration_since[<util.time_now>]>
        - flag <player> climbing_chalk_active:!
        on shutdown:
        - foreach <server.online_players_flagged[climbing_chalk_active]> as:plyr:
            - if <[plyr].flag_expiration[climbing_chalk_active].duration_since[<util.time_now>].is_less_than[30s]>:
                - flag <[plyr]> climbing_chalk_active:!
                - stop
            - flag <[plyr]> climbing_chalk_offline_save:<[plyr].flag_expiration[climbing_chalk_active].duration_since[<util.time_now>]>
            - flag <[plyr]> climbing_chalk_active:!
        after player joins flagged:climbing_chalk_offline_save:
        - flag <player> climbing_chalk_active expire:<player.flag[climbing_chalk_offline_save]>
        - runlater climbing_chalk_low def:<player> delay:<player.flag[climbing_chalk_offline_save].sub[30s]>
        - flag <player> climbing_chalk_offline_save:!
        - adjust <player> send_climbable_materials:<server.vanilla_tagged_materials[climbable].include[iron_bars|chain].include[<server.vanilla_tagged_materials[walls]>].include[<server.vanilla_tagged_materials[fences]>].include[<server.vanilla_tagged_materials[buttons]>]>
        - narrate "<aqua>You sense your grip retains its strength."
        after server resources reloaded:
        - foreach <server.online_players_flagged[climbing_chalk_active]> as:plyr:
            - adjust <[plyr]> send_climbable_materials:<server.vanilla_tagged_materials[climbable].include[iron_bars|chain].include[<server.vanilla_tagged_materials[walls]>].include[<server.vanilla_tagged_materials[fences]>].include[<server.vanilla_tagged_materials[buttons]>]>

climbing_chalk_low:
    type: task
    debug: false
    definitions: plyr
    script:
    - if !<[plyr].is_online> || <[plyr].flag_expiration[climbing_chalk_active].duration_since[<util.time_now>].is_more_than[30s]>:
        - stop
    - narrate targets:<[plyr]> "<red>You feel your grip begin to weaken."
    - runlater climbing_chalk_out def:<[plyr]> delay:31s

climbing_chalk_out:
    type: task
    debug: false
    definitions: plyr
    script:
    - if !<[plyr].is_online> || <[plyr].flag[climbing_chalk_active].exists>:
        - stop
    - narrate targets:<[plyr]> "<red>You have run out of chalk."
    - adjust <[plyr]> send_climbable_materials:<server.vanilla_tagged_materials[climbable]>
