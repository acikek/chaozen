# All modifier scripts should start with "mob_mod_" and end with the name of the modifier.
# "mob_mod_" is cropped from the id when the modifier is registered.

mob_modifier_register:
    type: task
    debug: false
    description: Registers all mob modifiers.
    script:
        # Get all scripts that start with "mob_mod_" and parse their ids.
        # There is technically no requirement that the script name starts with "mob_mod_" but it is recommended for organization.
        - define valid_modifiers <util.scripts.filter_tag[<[filter_value].data_key[mob_modifier].exists>].parse_tag[<[parse_value].data_key[mob_modifier].with[id].as[<[parse_value].name.after[mob_mod_]>]>]>
        # Get prefix and suffix modifiers.
        - define prefix_modifiers <[valid_modifiers].filter_tag[<[filter_value].get[type].equals[prefix]>]>
        - define suffix_modifiers <[valid_modifiers].filter_tag[<[filter_value].get[type].equals[suffix]>]>

        # Clear server flags.
        - flag server mob_modifiers:!

        # Flag the server with the modifiers for easy access.
        - foreach <[prefix_modifiers]> as:prefix_data:
            - flag server mob_modifiers.prefixes.<[prefix_data].get[id]>:<[prefix_data].get[weight]>
        - foreach <[suffix_modifiers]> as:suffix_data:
            - flag server mob_modifiers.suffixes.<[suffix_data].get[id]>:<[suffix_data].get[weight]>

        - define config <script[mob_modifier_config]>

        # Flag the server with the global chance for easy access.
        - flag server mob_modifiers.chance:<[config].data_key[chance]>

# Register modifiers after reload and restart.
mob_modifier_reload:
    type: world
    debug: false
    events:
        after scripts loaded:
            - inject mob_modifier_register