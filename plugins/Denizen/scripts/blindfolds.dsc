blindfold:
    type: item
    display name: <&f>Blindfold
    material: nether_brick_slab
    flags:
        is_blindfold: head
    lore:
        - <&7>Your vision is obscured by something.
        - <&7>Somehow, you feel safer.


blindfold_wear:
    type: world
    debug: false
    events:
        on player dies flagged:blindfold_on:
            - flag player blindfold_on:!

        on player right clicks block with:blindfold:
            - determine passively cancelled
            - if <player.inventory.slot[40].material.name> == air:
                - flag player blindfold_on
                - equip <player> head:<context.item>
                - take item:<context.item>

        after player clicks blindfold in inventory slot:40:
            - flag player blindfold_on:!

        on delta time secondly:
            - repeat 4:
                - foreach <server.online_players_flagged[blindfold_on]> as:__player:
                    - cast blindness amplifier:155 duration:3s no_icon hide_particles
                    - cast darkness amplifier:155 duration:3s no_icon hide_particles

        on enderman targets player flagged:blindfold_on:
            - determine passively cancelled
        on phantom targets player flagged:blindfold_on:
            - determine passively cancelled