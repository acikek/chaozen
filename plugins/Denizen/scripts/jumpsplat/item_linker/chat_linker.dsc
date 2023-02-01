# Messages that contain {main_hand}, {off_hand}, {boots},
# {leggings}, {chestplate} or {helmet} will instead replace
# the bracketed text with the item in the corresponding slot.
# Show off your cool stuff to all your friends!

chat_linker:
    type: world
    debug: false
    events:
        on player chats priority:1000:
            - define message <context.full_text>
            - definemap items:
                main_hand: <player.item_in_hand>
                off_hand: <player.item_in_offhand>
                boots: <player.equipment.get[1]>
                leggings: <player.equipment.get[2]>
                chestplate: <player.equipment.get[3]>
                helmet: <player.equipment.get[4]>
            - foreach <[items]> as:item:
                - define display <[item].display.if_null[<[item].material.translated_name>].on_hover[<[item]>].type[SHOW_ITEM]>
                - define message <[message].replace_text[{<[key]>}].with[<[display].underline>]>
            - determine <[message]>
