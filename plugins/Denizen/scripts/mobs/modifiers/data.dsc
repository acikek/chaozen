mob_modifier_config:
    type: data

    # The chance of a mob having a modifier (percentage).
    chance: 20

    builds:
        common:
            name: Common
            color: <color[gray]>
            prefixes: 1
            suffixes: 0
            weight: 3
            matches: monster
            blacklisted_modifiers:
                - none
        rare:
            name: Rare
            color: <color[blue]>
            prefixes: 3
            suffixes: 1
            weight: 1
            matches: monster
            blacklisted_modifiers:
                - none