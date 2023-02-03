# This file is for prefixes that take up less than 20 lines of code. If you have a prefix that takes up more than 20 lines of code, please make a new file for it.
# This includes the entire script container, not just the script itself.

mob_mod_speedy:
    type: world
    debug: false
    mob_modifier:
        type: prefix
    events:
        after entity_flagged:mob_modifiers.speedy spawns:
            - adjust <context.entity> speed:<context.entity.speed.mul[1.5]>

mob_mod_armored:
    type: world
    debug: false
    mob_modifier:
        type: prefix
    events:
        after entity_flagged:mob_modifiers.armored spawns:
            - flag <context.entity> armored:0 if:<context.entity.has_flag[armored].not>
            - flag <context.entity> armored:+:5

mob_mod_regenerating:
    type: world
    debug: false
    mob_modifier:
        type: prefix
    events:
        after entity_flagged:mob_modifiers.regenerating damaged:
            - stop if:<context.entity.exists.not>
            - cast regeneration <context.entity> amplifier:2 duration:<util.random.int[3].to[10]>s
            - playeffect at:<context.entity.eye_location> quantity:50 effect:villager_happy offset:0.5,0.5,0.5