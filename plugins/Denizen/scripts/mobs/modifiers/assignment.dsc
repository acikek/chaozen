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
            - define selected_prefixes <[valid_prefixes].random[<[build].get[prefixes]>]>
            - define selected_suffixes <[valid_suffixes].random[<[build].get[suffixes]>]>
            - foreach <[selected_prefixes]> as:prefix:
                - flag <context.entity> mob_modifiers.<[prefix]>
            - foreach <[selected_suffixes]> as:suffix:
                - flag <context.entity> mob_modifiers.<[suffix]>
            - define name <[selected_prefixes].parse_tag[<[parse_value].proc[snake_case_to_title_case]>].space_separated> <context.entity.custom_name.if_null[<context.entity.entity_type.proc[snake_case_to_title_case]>]> <[selected_suffixes].parse_tag[<[parse_value].proc[snake_case_to_title_case]>].space_separated>
            - adjust <context.entity> custom_name:<[name]>