restraining_order:
    type: item
    display name: <&f>Restraining Order
    material: paper
    flags:
        uuid: <util.random_uuid>
    lore:
        - <&7>Right click to assign to a player!
restraining_order_handler:
    type: world
    debug: true
    events:
        on player right clicks entity with:restraining_order type:player:
            - if <context.item.has_flag[restrained]>:
                - stop
            - define slot <player.held_item_slot>
            - inventory flag slot:<[slot]> restrained:<context.entity.name>
            - define item <player.item_in_hand>
            - inventory adjust slot:<[slot]> lore:<&7>Attached<&sp>to<&sp><[item].flag[restrained]>
            - flag <context.entity> restraining_order_<player>:<player>
            - flag <context.entity> restraining_order<player>
            - narrate "<&7>You have <[item].flag[restrained]> set for your restraining order!"
        on player holds item item:restraining_order:
            - flag player holding_restraining_order
        on player holds item item:!restraining_order flagged:holding_restraining_order:
            - flag player holding_restraining_order:!
        on player steps on block flagged:holding_restraining_order:
            - define target <player.location.find_players_within[5].filter[flag[restraining_order_<player>].equals[<player>]]>
            - if <[target].any>:
                - adjust <[target].first> velocity:<[target].first.location.sub[<player.location>].with_y[0.5].normalize.mul[0.5]>
