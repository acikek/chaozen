# This file is for suffixes that take up less than 20 lines of code. If you have a suffix that takes up more than 20 lines of code, please make a new file for it.
# This includes the entire script container, not just the script itself.

mob_mod_exploding:
    type: world
    mob_modifier:
        type: suffix
    events:
        on entity_flagged:mob_modifiers.exploding dies:
            - explode <context.entity.eye_location> power:1.3