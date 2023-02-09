mob_mod_fishy:
    type: world
    debug: false
    mob_modifier:
        type: suffix
    events:
        on entity_flagged:mob_modifiers.fishy dies:
            - define location <context.entity.eye_location>
            - repeat <util.random.int[3].to[10]>:
                - spawn mob_modifiers_entity_exploding_fish <[location]>
                - wait 4t
        on entity_flagged:mob_modifiers_other.exploding_fish dies:
            - explode <context.entity.eye_location> power:2.5
 
mob_modifiers_entity_exploding_fish:
    type: entity
    entity_type: tropical_fish
    debug: false
    mechanisms:
        custom_name: <&c>Exploding Fish
        custom_name_visible: true
    flags:
        mob_modifiers_other.exploding_fish: true