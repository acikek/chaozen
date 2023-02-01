# All modifier scripts should start with "mob_mod_" and end with the name of the modifier.
# "mob_mod_" is cropped from the id when the modifier is registered.

mob_modifier_registry:
    type: task
    debug: false
    script:
        - define valid_modifiers <util.scripts.filter_tag[<[filter_value].data_key[mob_modifier].exists>].parse_tag[<[parse_value].data_key[mob_modifier].with[id].as[<[parse_value].name.after[mob_mod_]>]>]>
        - define prefix_modifiers <[valid_modifiers].filter_tag[<[filter_value].get[type].equals[prefix]>].parse_tag[<[parse_value].get[id]>]>
        - define suffix_modifiers <[valid_modifiers].filter_tag[<[filter_value].get[type].equals[suffix]>].parse_tag[<[parse_value].get[id]>]>

        - flag server mob_modifiers.prefixes:<[prefix_modifiers]>
        - flag server mob_modifiers.suffixes:<[suffix_modifiers]>

        - define config <script[mob_modifier_config]>

        - flag server mob_modifiers.chance:<[config].data_key[chance]>

mob_modifier_reload:
    type: world
    debug: false
    events:
        after server start:
            - inject mob_modifier_registry
        after reload scripts:
            - inject mob_modifier_registry