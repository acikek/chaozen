# This file is for suffixes that take up less than 20 lines of code. If you have a suffix that takes up more than 20 lines of code, please make a new file for it.
# This includes the entire script container, not just the script itself.

mob_mod_exploding:
    type: world
    debug: false
    mob_modifier:
        type: suffix
    events:
        on entity_flagged:mob_modifiers.exploding dies:
            - explode <context.entity.eye_location> power:1.3

mob_mod_supercharged:
    type: world
    debug: false
    mob_modifier:
        type: suffix
    events:
        on entity_flagged:mob_modifiers.supercharged dies:
            - foreach <context.entity.eye_location.find_entities[living].within[5]> as:target:
                - strike <[target].location>
                - burn <[target]> duration:5s if:<[target].on_fire.not>