mob_modifiers_spawned_entity:
    type: world
    debug: false
    events:
        on living spawns:
            # If the random chance for it to have modifiers is not met, stop.
            - stop if:<util.random_chance[<server.flag[mob_modifiers.chance]>].not>
            # Get a random build from the config based on the entity.
            - define build <script[mob_modifier_config].data_key[builds].get[<context.entity.proc[mob_modifiers_get_random_build]>]>
            # Get all the valid modifiers for the build.
            - define valid_modifiers <[build].proc[mob_modifiers_get_valid_suffixes_and_prefixes_for_build]>
            # Get the valid prefixes and suffixes for the build.
            - define valid_prefixes <[valid_modifiers].first.keys>
            - define valid_suffixes <[valid_modifiers].last.keys>
            # If the number of valid prefixes or suffixes is less than the number of prefixes or suffixes the build has, stop.
            - if <[valid_prefixes].size> < <[build].get[prefixes]> or <[valid_suffixes].size> < <[build].get[suffixes]>:
                - stop
            # Get the selected prefixes and suffixes.
            - define selected_prefixes <list>
            - define selected_suffixes <list>
            - repeat <[build].get[prefixes]>:
                - define selected_prefixes <[selected_prefixes].include[<proc[mob_modifiers_get_random_modifier].context[prefix|<[build].get[name]>|<[selected_prefixes]>]>]>
            - repeat <[build].get[suffixes]>:
                - define selected_suffixes <[selected_suffixes].include[<proc[mob_modifiers_get_random_modifier].context[suffix|<[build].get[name]>|<[selected_suffixes]>]>]>
            # Set the flags on the entity for the prefixes and suffixes.
            - foreach <[selected_prefixes]> as:prefix:
                - flag <context.entity> mob_modifiers.<[prefix]>
            - foreach <[selected_suffixes]> as:suffix:
                - flag <context.entity> mob_modifiers.<[suffix]>
            # Set the entity's custom name.
            - define color <&color[<[build].get[color]>]>
            - define formatted_prefixes <[selected_prefixes].parse_tag[<[parse_value].proc[snake_case_to_spaced_title_case]>].space_separated>
            - define formatted_suffixes <[selected_suffixes].parse_tag[<[parse_value].proc[snake_case_to_spaced_title_case]>].space_separated>
            - define entity_name <context.entity.custom_name.if_null[<context.entity.entity_type.proc[snake_case_to_spaced_title_case]>]>
            - if <[selected_suffixes].any>:
                - define name "<[color]><[formatted_prefixes]> <&f><[entity_name]> <[color]>The <[formatted_suffixes]>"
            - else:
                - define name "<[color]><[formatted_prefixes]> <&f><[entity_name]>"
            - adjust <context.entity> custom_name:<[name]>
            - adjust <context.entity> custom_name_visible:true