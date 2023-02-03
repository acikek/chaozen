baguette:
    type: item
    display name: <&f>Baguette
    material: bread
    flags:
        bites: 4
        uuid: <util.random_uuid>
    lore:
    - <&7>It's so long that it
    - <&7>takes 5 bites to eat.
    - <&7>
    - <&7>Bites left: <&8>5
    recipes:
        1:
            type: shapeless
            input: bread|bread|bread|bread|bread

baguette_eat:
    type: world
    debug: false
    events:
        on player consumes baguette:
            - define item <player.item_in_hand>
            - if <[item].flag[bites]> <= 0:
                - feed amount:17 saturation:<[item].flag[bites].add[4]>
                - stop
            - determine passively cancelled
            - define amount <element[10].sub[<element[2].mul[<[item].flag[bites]>]>]>
            - feed amount:<[amount]> saturation:<[item].flag[bites].add[4]>
            - inventory flag slot:hand bites:--
            - inventory adjust slot:hand "lore:<[item].lore.set[<&7>Bites left: <&8><[item].flag[bites]>].at[4]>"