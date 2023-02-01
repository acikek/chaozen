mob_modifiers_get_valid_builds:
    type: procedure
    definitions: entity[entity to match against]
    script:
        - define valid_builds <list>
        - foreach <script[mob_modifier_config].data_key[builds]> as:build:
            - if <[build].get[matches].advanced_matches[<[entity]>]>:
                - define valid_builds:->:<[build]>
        - determine <[valid_builds]>

mob_modifiers_get_all_modifiers:
    type: procedure
    script:
        - determine <server.flag[mob_modifiers.suffixes].include[<server.flag[mob_modifiers.prefixes]>].alphanumeric>

mob_modifiers_get_valid_modifiers_for_build:
    type: procedure
    definitions: build[build to match against]
    script:
        - define modifiers <proc[mob_modifiers_get_all_modifiers]>
        - define valid_modifiers <list>
        - foreach <[modifiers]> as:modifier:
            - if not <[builds].get[blacklisted_modifiers].contains[<[modifier]>]>:
                - define valid_modifiers:->:<[modifier]>

mob_modifiers_get_valid_prefixes_for_build:
    type: procedure
    definitions: build[build to match against]
    script:
        - define prefixes <server.flag[mob_modifiers.prefixes]>
        - define valid_prefixes <list>
        - foreach <[prefixes]> as:prefix:
            - if not <[builds].get[blacklisted_modifiers].contains[<[prefix]>]>:
                - define valid_prefixes:->:<[prefix]>
        - determine <[valid_prefixes]>

mob_modifiers_get_valid_suffixes_for_build:
    type: procedure
    definitions: build[build to match against]
    script:
        - define suffixes <server.flag[mob_modifiers.suffixes]>
        - define valid_suffixes <list>
        - foreach <[suffixes]> as:suffix:
            - if not <[builds].get[blacklisted_modifiers].contains[<[suffix]>]>:
                - define valid_suffixes:->:<[suffix]>
        - determine <[valid_suffixes]>

mob_modifiers_get_random_build:
    type: procedure
    definitions: entity[entity to match with]
    script:
        - define builds <[entity].proc[mob_modifiers_get_valid_builds]>
        - define weighted_builds <map>
        - foreach <[builds]> as:build:
            - define weighted_builds.<[build].get[name]> <[build].get[weight]>
        - determine <[weighted_builds].proc[get_random_item_from_weighted_map]>