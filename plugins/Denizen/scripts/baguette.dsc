baguette:
    type: item
    display name: <&f>Baguette
    material: bread
    flags:
        bites: 4
    lore:
    - <&7>Its so long that it
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
                - stop
            - inventory flag slot:hand bites:-:1
            - narrate <[item].flag[bites]>
            - inventory adjust slot:hand "lore:<&7>Its so long that it<n><&7>takes 5 bites to eat.<n><&7><n><&7>Bites left: <&8><[item].flag[bites]>"
