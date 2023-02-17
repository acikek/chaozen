mob_modifier_config:
    type: data

    builds:
        common:
            name: common
            color: white
            prefixes: 1
            suffixes: 0
            weight: 75
            matches: monster
            blacklisted_modifiers:
                - none
        rare:
            name: rare
            color: blue
            prefixes: 3
            suffixes: 1
            weight: 55
            matches: monster
            blacklisted_modifiers:
                - none
        epic:
            name: epic
            color: light_purple
            prefixes: 6
            suffixes: 2
            weight: 35
            matches: monster
            blacklisted_modifiers:
                - none
        legendary:
            name: legendary
            color: gold
            prefixes: 9
            suffixes: 3
            weight: 10
            matches: monster
            blacklisted_modifiers:
                - none