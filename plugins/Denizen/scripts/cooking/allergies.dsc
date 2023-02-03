allergies:
    type: world
    debug: false
    events:
        on player dies:
            - if <util.random_chance[12]>:

                - define allergy <script[allergies].data_key[valid_allergies].keys.random>
                - define effect <script[allergies].data_key[valid_effects].keys.random>
                - flag player allergic:<[allergy]>
                - narrate <[allergy]>
                - flag player allergy_effect:<[effect]>
                - stop
            - flag player allergic:!
            - flag player allergy_effect:!

        on player consumes item flagged:allergic:

            - define allergies <script[allergies].data_key[valid_allergies].keys>
            - if <[allergies].contains[<context.item.script.name.if_null[<context.item.material.name>]>]>:
                - foreach <player.flag[allergy_effect]> as:a:
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
            - milk
            - cake
        pumpkin:
            - pumpkin_pie


    valid_effects:
        hives:
            poison:
                duration: 2m
                amplifier: 1
        vomit:
            confusion:
                duration: 30s
                amplifier: 5
            slow:
                duration: 1m
                amplifier: 2
        swelling:
            slow_digging:
                duration: 15s
                amplifier: 1

        cramps:
            slow:
                duration: 5m
                amplifier: 1
            slow_digging:
                duration: 5s
                amplifier: 5
            poison:
                duration: 5s
                amplifier: 1