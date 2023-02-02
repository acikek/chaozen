climbing_chalk:
    type: item
    material: sugar
    allow in material recipes: false
    display name: <&[item]>Climbing Chalk
    lore:
    - <&[emphasis]>Strengthens your grip.
    - <&[lore]>Allows you to climb on fences, inner walls, buttons, chains, and iron bars.
    - <&[lore]>Lasts 5 minutes.
    - <&[lore]><&keybind[key.sneak]> + <&keybind[key.use]> in air to apply.
    recipes:
        1:
            type: shapeless
            output_quantity: 4
            input: calcite

climbing_chalk_handler:
    type: world
    debug: false
    events:
        on server start:
        - flag server climbable_materials:<server.vanilla_tagged_materials[climbable].include[iron_bars|chain].include[<server.vanilla_tagged_materials[walls]>].include[<server.vanilla_tagged_materials[fences]>].include[<server.vanilla_tagged_materials[buttons]>]>
        on player right clicks air with:climbing_chalk:
        - ratelimit <player> 1t
        - if <player.is_sneaking>:
            - run climbing_chalk_add_time
        on player quits flagged:climbing_chalk.active:
        - run climbing_chalk_save_duration
        on shutdown:
        - foreach <server.online_players_flagged[climbing_chalk.active]> as:__player:
            - run climbing_chalk_save_duration
        after player joins flagged:climbing_chalk.offline_save:
        - flag <player> climbing_chalk.active expire:<player.flag[climbing_chalk.offline_save]>
        - runlater climbing_chalk_low delay:<player.flag[climbing_chalk.offline_save].sub[30s]>
        - flag <player> climbing_chalk.offline_save:!
        - adjust <player> send_climbable_materials:<server.flag[climbable_materials]>
        - narrate "<&[emphasis]>You sense your grip retains its strength."
        after server resources reloaded:
        - foreach <server.online_players_flagged[climbing_chalk.active]> as:plyr:
            - adjust <player> send_climbable_materials:<server.flag[climbable_materials]>

climbing_chalk_add_time:
    type: task
    debug: false
    script:
    - define chalk_duration 5m
    - if <player.flag[climbing_chalk.active].exists>:
        - if <player.flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].is_more_than[30s]>:
            - narrate "<&[error]>You have enough chalk for the moment."
            - stop
        - define chalk_duration <player.flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].add[5m]>
    - if <player.flag[climbing_chalk.offline_save].exists>:
        - define chalk_duration <player.flag[climbing_chalk.offline_save]>
    - take item:climbing_chalk quantity:1 from:<player.inventory>
    - flag <player> climbing_chalk.active expire:<[chalk_duration]>
    - adjust <player> send_climbable_materials:<server.flag[climbable_materials]>
    - narrate "<&[emphasis]>You apply some chalk to your hands, strengthening your grip."
    - runlater climbing_chalk_low delay:<player.flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].sub[30s]>

climbing_chalk_save_duration:
    type: task
    debug: false
    script:
    - if <player.flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].is_less_than[30s]>:
        - flag <player> climbing_chalk.active:!
        - stop
    - flag <player> climbing_chalk.offline_save:<player.flag_expiration[climbing_chalk.active].duration_since[<util.time_now>]>
    - flag <player> climbing_chalk.active:!

climbing_chalk_low:
    type: task
    debug: false
    script:
    - if not <player.is_online> or <player.flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].is_more_than[30s]>:
        - stop
    - narrate targets:<player> "<&[warning]>You feel your grip begin to weaken."
    - runlater climbing_chalk_out delay:31s

climbing_chalk_out:
    type: task
    debug: false
    script:
    - if not <player.is_online> or <player.flag[climbing_chalk.active].exists>:
        - stop
    - narrate targets:<player> "<&[warning]>You have run out of chalk."
    - adjust <player> send_climbable_materials:<server.vanilla_tagged_materials[climbable]>
