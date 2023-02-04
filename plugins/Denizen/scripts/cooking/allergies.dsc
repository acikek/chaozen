allergies:
    type: world
    debug: false
    events:
        on player dies:
            - if <util.random_chance[12]>:
                - define allergy <script[allergy_info].data_key[allergies].keys.random>
                - define effect <script[allergy_info].data_key[symptoms].keys.random>
                - definemap to_player:
                    allergy: <[allergy]>
                    allergy_effect: <[effect]>
                - flag <player> allergic:<[to_player]>
                - stop
            - flag <player> allergic:!

        after player consumes item flagged:allergic:

            - define allergies_data <script[allergy_info].data_key[allergies.<player.flag[allergic].get[allergy]>]>
            - if <[allergies_data].contains[<context.item.script.name.if_null[<context.item.material.name>]>]>:
                - foreach <script[allergy_info].data_key[symptoms.<player.flag[allergic].get[allergy_effect]>]> as:data key:effect:
                    - cast <[effect]> duration:<[data].get[duration]> amplifier:<[data].get[amplifier]> hide_particles no_icon

allergy_info:
    type: data
    allergies:
        seafood:
            - raw_salmon
            - cooked_salmon
            - raw_cod
            - cooked_cod
            - pufferfish
            - dried_kelp
        wheat:
            - bread
            - baguette
            - cake
            - cookie
        dairy:
            - milk_bucket
            - cake
        pumpkin:
            - pumpkin_pie
        starch:
            - potato
            - baked_potato
            - bread
        sugar:
            - apple
            - golden_apple
            - enchanted_golden_apple
            - sweet_berries
            - chorus_fruit
            - melon_slice
            - cake
            - cookie
            - pumpkin_pie
            - honey
        honey:
            - honey_bottle


    symptoms:
        hives:
            poison:
                duration: 2m
                amplifier: 3
            slow:
                duration: 2m
                amplifier: 1
        vomit:
            confusion:
                duration: 45s
                amplifier: 100
            slow:
                duration: 20s
                amplifier: 3
            hunger:
                duration: 20s
                amplifier: 155
        swelling:
            slow_digging:
                duration: 3m
                amplifier: 0
            wither:
                duration: 3m
                amplifier: 1

        cramps:
            slow:
                duration: 5m
                amplifier: 6
            slow_digging:
                duration: 30s
                amplifier: 1
            poison:
                duration: 2m
                amplifier: 0

        diarrhea:
            slow:
                duration: 15s
                amplifier: 5
            hunger:
                duration: 15s
                amplifier: 255

allergy_testing_tool:
    type: item
    display name: <&f>Allergy Testing Tool
    material: amethyst_shard


allergy_testing:
    type: world
    debug: false
    events:
        on player right clicks block with:allergy_testing_tool:
            - ratelimit <player> 5t
            - take slot:hand
            - if !<player.has_flag[allergic]>:
                - narrate "<&7>Nothing happens."
                - stop

            - narrate "<&7>Your body reacts..."
            - wait 1s
            - narrate "<&7>You are allergic to <player.flag[allergic].get[allergy]>."
            - foreach <script[allergy_info].data_key[symptoms.<player.flag[allergic].get[allergy_effect]>]> as:data key:effect:
                - cast <[effect]> duration:<[data].get[duration]> amplifier:<[data].get[amplifier]> hide_particles no_icon