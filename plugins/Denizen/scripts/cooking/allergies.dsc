allergies:
    type: world
    debug: false
    events:
        on player dies:
            - if <util.random_chance[12]>:
                - define allergy <script[allergy_info].data_key[valid_allergies].keys.random>
                - define effect <script[allergy_info].data_key[valid_effects].keys.random>
                - flag player allergic:<[allergy]>
                - flag player allergy_effect:<[effect]>
                - stop
            - flag player allergic:!
            - flag player allergy_effect:!

        on player consumes item flagged:allergic:

            - define allergies_data <script[allergy_info].data_key[valid_allergies.<player.flag[allergic]>]>
            - if <[allergies_data].contains[<context.item.script.name.if_null[<context.item.material.name>]>]>:
                - foreach <script[allergy_info].data_key[valid_effects.<player.flag[allergy_effect]>]> as:a key:b:
                    - cast <[b]> duration:<[a].get[duration]> amplifier:<[a].get[amplifier]> hide_particles no_icon

allergy_info:
    type: data
    valid_allergies:
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
        diary:
            - milk_bucket
            - cake
        pumpkin:
            - pumpkin_pie
            - pumpkin


    valid_effects:
        hives:
            poison:
                duration: 2m
                amplifier: 1
        vomit:
            confusion:
                duration: 45s
                amplifier: 100
            slow:
                duration: 20s
                amplifier: 4
            hunger:
                duration: 20s
                amplifier: 155
        swelling:
            slow_digging:
                duration: 30s
                amplifier: 1
            wither:
                duration: 10s
                amplifier: 1

        cramps:
            slow:
                duration: 5m
                amplifier: 6
            slow_digging:
                duration: 5s
                amplifier: 5
            poison:
                duration: 5s
                amplifier: 1