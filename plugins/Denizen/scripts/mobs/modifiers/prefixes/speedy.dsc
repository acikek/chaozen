mob_mod_speedy:
    type: world
    mob_modifier:
        type: prefix
    events:
        after entity_flagged:mob_modifiers.speedy spawns:
            - adjust <context.entity> speed:<context.entity.speed.mul[1.5]>