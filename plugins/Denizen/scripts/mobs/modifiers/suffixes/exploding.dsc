mob_mod_exploding:
    type: world
    mob_modifier:
        type: suffix
    events:
        on entity_flagged:mob_modifiers.exploding dies:
            - explode <context.entity.eye_location> power:1.3