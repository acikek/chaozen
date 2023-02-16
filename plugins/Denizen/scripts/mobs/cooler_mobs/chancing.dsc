# Collection of procedures for Mob Modifiers relating to the build system and getting random builds.

mob_modifiers_get_valid_builds:
    type: procedure
    debug: false
    definitions: entity[entity to match against]
    script:
        - define valid_builds <list>
        - foreach <script[mob_modifier_config].data_key[builds]> as:build:
            - if <[entity].advanced_matches[<[build].get[matches]>]>:
                - define valid_builds:->:<[build]>
        - determine <[valid_builds]>

mob_modifiers_get_all_modifiers:
    type: procedure
    debug: false
    script:
        - determine <server.flag[mob_modifiers.suffixes].include[<server.flag[mob_modifiers.prefixes]>]>

mob_modifiers_get_valid_modifiers_for_build:
    type: procedure
    debug: false
    definitions: build[build to match against]
    script:
        - define modifiers <proc[mob_modifiers_get_all_modifiers]>
        - define valid_modifiers <list>
        - foreach <[modifiers]> as:modifier:
            - if not <[build].get[blacklisted_modifiers].contains[<[modifier]>]>:
                - define valid_modifiers:->:<[modifier]>

mob_modifiers_get_valid_suffixes_and_prefixes_for_build:
    type: procedure
    debug: false
    description:
        - Gets a list containing the valid prefixes and suffixes for a given build.
        - For clarification, it's a list of lists containing the prefixes and suffixes.
    definitions: build[build to match against]
    script:
        - define prefixes <server.flag[mob_modifiers.prefixes].keys>
        - define suffixes <server.flag[mob_modifiers.suffixes].keys>
        - define valid_prefixes <list>
        - define valid_suffixes <list>
        - foreach <[prefixes]> as:prefix:
            - if not <[build].get[blacklisted_modifiers].contains[<[prefix]>]>:
                - define valid_prefixes:->:<[prefix]>
        - foreach <[suffixes]> as:suffix:
            - if not <[build].get[blacklisted_modifiers].contains[<[suffix]>]>:
                - define valid_suffixes:->:<[suffix]>
        - determine <list_single[<[valid_prefixes]>].include_single[<[valid_suffixes]>]>

mob_modifiers_get_random_build:
    type: procedure
    debug: false
    description: Gets a random build from the build list for an entity.
    definitions: entity[entity to match with]
    script:
        - define builds <[entity].proc[mob_modifiers_get_valid_builds]>
        - define weighted_builds <map>
        - foreach <[builds]> as:build:
            - define weighted_builds <[weighted_builds].with[<[build].get[name].to_lowercase>].as[<[build].get[weight]>]>
        - determine <[weighted_builds].proc[get_random_item_from_weighted_map]>

mob_modifiers_get_random_modifier:
    type: procedure
    debug: false
    description: Gets a random modifier from the modifier list.
    definitions: type[prefix or suffix modifier]|build[build to match with]|already_used_modifiers[list of already used modifiers on the entity]
    script:
        - define modifiers <script[mob_modifier_config].data_key[builds].get[<[build].to_lowercase>].proc[mob_modifiers_get_valid_suffixes_and_prefixes_for_build].get[<[type].equals[prefix].if_true[1].if_false[2]>]>
        - define weighted_modifiers <map>
        - foreach <[modifiers].exclude[<[already_used_modifiers]>]> as:modifier:
            - define weight <server.flag[mob_modifiers.<[type]>es].get[<[modifier].to_lowercase>]>
            - define weighted_modifiers <[weighted_modifiers].with[<[modifier]>].as[<[weight]>]>
        - determine <[weighted_modifiers].proc[get_random_item_from_weighted_map]>