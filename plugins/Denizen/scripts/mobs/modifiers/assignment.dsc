mob_modifiers_spawned_entity:
    type: world
    debug: false
    events:
        on !player spawns:
            - stop if:<util.random_chance[<server.flag[mob_modifiers.chance]>].not>
            - define build <context.entity.proc[mob_modifiers_get_random_build]>
            - define valid_prefixes <[build].proc[mob_modifiers_get_valid_prefixes_for_build]>
            - define valid_suffixes <[build].proc[mob_modifiers_get_valid_suffixes_for_build]>
            - if <[valid_prefixes].is_empty> and <[valid_suffixes].is_empty>:
                - stop
            - foreach <[valid_prefixes].random[<[build].get[prefixes]>]> as:prefix:
                - flag <context.entity> mob_modifiers.<[prefix]>
            - foreach <[valid_suffixes].random[<[build].get[suffixes]>]> as:suffix:
                - flag <context.entity> mob_modifiers.<[suffix]>