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