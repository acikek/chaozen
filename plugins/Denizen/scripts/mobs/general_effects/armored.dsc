armored_events:
    type: world
    debug: false
    events:
        on entity_flagged:armored takes damage:
            - if <context.entity.flag[armored].is_integer.not>:
                - flag <context.entity> armored:!
                - stop
            - flag <context.entity> armored:--
            - if <context.entity.flag[armored]> < 1:
                - flag <context.entity> armored:!
            - determine passively cancelled
            - playsound <context.entity.eye_location> sound:item_shield_break pitch:2 volume:2 sound_category:master
            - playeffect at:<context.entity.eye_location> effect:item_crack quantity:100 offset:0.5,0.5,0.5 special_data:shield