restraining_order:
    type: item
    display name: <&f>Restraining Order
    material: paper
    flags:
        uuid: <util.random_uuid>
    lore:
        - <&7>Right click a player
        - <&7>to restrain them from
        - <&7>you!

restraining_order_handler:
    type: world
    debug: false
    events:
        on player right clicks entity with:restraining_order type:player:
            - if <context.item.has_flag[restrained]>:
                - stop
            - inventory flag slot:hand restrained:<context.entity>
            - define item <player.item_in_hand>
            - inventory adjust slot:hand "lore:<&7>Attached to <[item].flag[restrained].name>"
            - flag <[item].flag[restrained]> restraining_order:->:<player>
            - narrate "<&7>You have placed a restraining order on <[item].flag[restrained].name>!"

        on player holds item item:restraining_order:
            - flag player holding_restraining_order
        on player holds item item:!restraining_order flagged:holding_restraining_order:
            - flag player holding_restraining_order:!
        on player steps on block flagged:holding_restraining_order:
            - define target <player.location.find_players_within[5].filter[flag[restraining_order].contains[<player>]].exclude[<player>]>
            - if <[target].any>:
                - adjust <[target].first> velocity:<[target].first.location.sub[<player.location>].with_y[0.5].normalize.mul[0.5]>
