mob_modifiers_spawned_entity:
    type: world
    debug: false
    events:
        on !player spawns:
            - stop if:<util.random_chance[<server.flag[mob_modifiers.chance]>].not>
            - define build <context.entity.proc[mob_modifiers_get_random_build]>
            - define build <script[mob_modifier_config].data_key[builds].get[<[build]>]>
            - define valid_prefixes <[build].proc[mob_modifiers_get_valid_prefixes_for_build]>
            - define valid_suffixes <[build].proc[mob_modifiers_get_valid_suffixes_for_build]>
            - if <[valid_prefixes].size> < <[build].get[prefixes]> or <[valid_suffixes].size> < <[build].get[suffixes]>:
                - stop
            - define selected_prefixes <[valid_prefixes].random[<[build].get[prefixes]>]>
            - define selected_suffixes <[valid_suffixes].random[<[build].get[suffixes]>]>
            - foreach <[selected_prefixes]> as:prefix:
                - flag <context.entity> mob_modifiers.<[prefix]>
            - foreach <[selected_suffixes]> as:suffix:
                - flag <context.entity> mob_modifiers.<[suffix]>
            - define color <&color[<[build].get[color]>]>
            - define formatted_prefixes <[selected_prefixes].parse_tag[<[parse_value].proc[snake_case_to_title_case]>].space_separated>
            - define formatted_suffixes <[selected_suffixes].parse_tag[<[parse_value].proc[snake_case_to_title_case]>].space_separated>
            - define entity_name <context.entity.custom_name.if_null[<context.entity.entity_type.proc[snake_case_to_title_case]>]>
            - define name <[color]><[formatted_prefixes]> <&f><[entity_name]> <[color]><[formatted_suffixes]>
            - adjust <context.entity> custom_name:<[name]>