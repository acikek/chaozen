climbing_chalk:
    type: item
    material: sugar
    allow in material recipes: false
    display name: <dark_aqua>Climbing Chalk
    lore:
    - <gold>Strengthens your grip.
    - <&7>Allows you to climb on fences, inner walls, buttons, chains, and iron bars.
    - <&7>Lasts 5 minutes.
    - <&7><&keybind[key.sneak]> + <&keybind[key.use]> in air to apply.
    recipes:
        1:
            type: shapeless
            output_quantity: 4
            input: calcite

climbing_chalk_config:
    type: data
    colors:
        chalk_sufficient_warning: red
        chalk_low_warning: red
        chalk_out_warning: red
        chalk_applied: aqua

climbing_chalk_handler:
    type: world
    debug: false
    events:
        on server start:
        - flag server climbable_materials:<server.vanilla_tagged_materials[climbable].include[iron_bars|chain].include[<server.vanilla_tagged_materials[walls]>].include[<server.vanilla_tagged_materials[fences]>].include[<server.vanilla_tagged_materials[buttons]>]>
        on player right clicks air with:climbing_chalk:
        - ratelimit <player> 1t
        - if <player.is_sneaking>:
            - run climbing_chalk_add_time def:<player>
        on player quits flagged:climbing_chalk.active:
        - run climbing_chalk_save_duration def:<player>
        on shutdown:
        - foreach <server.online_players_flagged[climbing_chalk.active]> as:__player:
            - run climbing_chalk_save_duration def:<player>
        after player joins flagged:climbing_chalk.offline_save:
        - flag <player> climbing_chalk.active expire:<player.flag[climbing_chalk.offline_save]>
        - runlater climbing_chalk_low def:<player> delay:<player.flag[climbing_chalk.offline_save].sub[30s]>
        - flag <player> climbing_chalk.offline_save:!
        - adjust <player> send_climbable_materials:<server.flag[climbable_materials]
        - narrate "<&color[<script[climbing_chalk_config].data_key[colors.chalk_applied]>]>You sense your grip retains its strength."
        after server resources reloaded:
        - foreach <server.online_players_flagged[climbing_chalk.active]> as:plyr:
            - adjust <player> send_climbable_materials:<server.flag[climbable_materials]>

climbing_chalk_add_time:
    type: task
    debug: false
    definitions: plyr
    script:
    - define chalk_duration 5m
    - if <[plyr].flag[climbing_chalk.active].exists>:
        - if <[plyr].flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].is_more_than[30s]>:
            - narrate "<&color[<script[climbing_chalk_config].data_key[colors.chalk_sufficient_warning]>]>You have enough chalk for the moment."
            - stop
        - define chalk_duration <[plyr].flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].add[5m]>
    - if <[plyr].flag[climbing_chalk.offline_save].exists>:
        - define chalk_duration <[plyr].flag[climbing_chalk.offline_save]>
    - take item:climbing_chalk quantity:1 from:<[plyr].inventory>
    - flag <[plyr]> climbing_chalk.active expire:<[chalk_duration]>
    - adjust <[plyr]> send_climbable_materials:<server.flag[climbable_materials]>
    - narrate "<&color[<script[climbing_chalk_config].data_key[colors.chalk_applied]>]>You apply some chalk to your hands, strengthening your grip."
    - runlater climbing_chalk_low def:<[plyr]> delay:<[plyr].flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].sub[30s]>

climbing_chalk_save_duration:
    type: task
    debug: false
    definitions: plyr
    script:
    - if <[plyr].flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].is_less_than[30s]>:
        - flag <[plyr]> climbing_chalk.active:!
        - stop
    - flag <[plyr]> climbing_chalk.offline_save:<[plyr].flag_expiration[climbing_chalk.active].duration_since[<util.time_now>]>
    - flag <[plyr]> climbing_chalk.active:!

climbing_chalk_low:
    type: task
    debug: false
    definitions: plyr
    script:
    - if not <[plyr].is_online> or <[plyr].flag_expiration[climbing_chalk.active].duration_since[<util.time_now>].is_more_than[30s]>:
        - stop
    - narrate targets:<[plyr]> "<&color[<script[climbing_chalk_config].data_key[colors.chalk_low_warning]>]>You feel your grip begin to weaken."
    - runlater climbing_chalk_out def:<[plyr]> delay:31s

climbing_chalk_out:
    type: task
    debug: false
    definitions: plyr
    script:
    - if not <[plyr].is_online> or <[plyr].flag[climbing_chalk.active].exists>:
        - stop
    - narrate targets:<[plyr]> "<&color[<script[climbing_chalk_config].data_key[colors.chalk_out_warning]>]>You have run out of chalk."
    - adjust <[plyr]> send_climbable_materials:<server.vanilla_tagged_materials[climbable]>
