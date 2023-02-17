# This file is for suffixes that take up less than 20 lines of code. If you have a suffix that takes up more than 20 lines of code, please make a new file for it.
# This includes the entire script container, not just the script itself.

mob_mod_exploding:
    type: world
    debug: false
    mob_modifier:
        type: suffix
        weight: 5
    events:
        on entity_flagged:mob_modifiers.exploding dies:
            - explode <context.entity.eye_location> power:4.5

mob_mod_supercharged:
    type: world
    debug: false
    mob_modifier:
        type: suffix
        weight: 2
    events:
        on entity_flagged:mob_modifiers.supercharged dies:
            - foreach <context.entity.eye_location.find_entities[living].within[5]> as:target:
                - strike <[target].location>
                - burn <[target]> duration:5s if:<[target].on_fire.not>

mob_mod_ignored:
    type: world
    debug: false
    mob_modifier:
        type: suffix
        weight: 2
    events:
        on entity targets entity_flagged:mob_modifiers.ignored:
            - determine cancelled

mob_mod_butchering:
    type: world
    debug: false
    mob_modifier:
        type: suffix
        weight: 1
    events:
        on entity damaged by entity_flagged:mob_modifiers.butchering:
            - determine <context.damage.mul[<context.attacker.eye_location.find.living_entities.within[10].exclude[<context.entity>|<context.attacker>].size.mul[0.1].add[1]>]>

mob_mod_lavaforged:
    type: world
    debug: false
    mob_modifier:
        type: suffix
        weight: 1
    events:
        after entity damaged by entity_flagged:mob_modifiers.lavaforged:
            - burn <context.entity> duration:<context.damage.mul[1.35]>
        on entity_flagged:mob_modifiers.lavaforged damaged:
            - if <list[DRAGON_BREATH|DRYOUT|FIRE|FIRE_TICK|HOT_FLOOR|LAVA|MELTING]> contains <context.cause>:
                - determine cancelled