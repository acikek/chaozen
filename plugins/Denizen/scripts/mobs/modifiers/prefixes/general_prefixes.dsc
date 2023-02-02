# This file is for prefixes that take up less than 20 lines of code. If you have a prefix that takes up more than 20 lines of code, please make a new file for it.
# This includes the entire script container, not just the script itself.

mob_mod_speedy:
    type: world
    mob_modifier:
        type: prefix
    events:
        after entity_flagged:mob_modifiers.speedy spawns:
            - adjust <context.entity> speed:<context.entity.speed.mul[1.5]>