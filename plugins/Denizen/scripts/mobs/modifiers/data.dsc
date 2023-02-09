mob_modifier_config:
    type: data

    # The chance of a mob having a modifier (percentage).
    chance: 20

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
            weight: 25
            matches: monster
            blacklisted_modifiers:
                - none
        epic:
            name: epic
            color: light_purple
            prefixes: 6
            suffixes: 2
            weight: 15
            matches: monster
            blacklisted_modifiers:
                - none
        legendary:
            name: legendary
            color: orange
            prefixes: 9
            suffixes: 3
            weight: 10
            matches: monster
            blacklisted_modifiers:
                - none