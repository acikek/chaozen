# Shelled enemies will absorb a number of hits (specifically hits, not damage) and then break.

shelled_events:
    type: world
    debug: false
    events:
        on entity_flagged:shelled takes damage:
            - flag <context.entity> shelled:--
            - if <context.entity.flag[shelled]> < 1:
                - flag <context.entity> shelled:!
            - determine passively cancelled
            - playsound <context.entity.eye_location> sound:item_shield_break pitch:2 volume:2 sound_category:master
            - playeffect at:<context.entity.eye_location> effect:item_crack quantity:100 offset:0.5,0.5,0.5 special_data:shield

shelled_add:
    type: task
    debug: false
    description: Adds a shell to an entity.
    definitions: entity[entity you want to add a shell to]|amount[amount of shell to add (integer)]
    script:
        - if not <[entity].has_flag[shelled]> or not <[entity].flag[shelled].object_type.equals[element].if_null[false]>:
            - flag <[entity]> shelled:0
        - flag <[entity]> shelled:+:<[amount]>