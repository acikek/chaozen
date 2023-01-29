# -------------------------------------------------- #
# Script: toolreplace
# Author: LG_Legacy (84366968383082496)
# Date: 1/29/2023
# -------------------------------------------------- #

toolreplace_events:
    type: world
    debug: false
    events:
        after player breaks held item:
            - define i <context.item>
            - define inv <player.inventory>
            - define slots <[inv].find_all_items[<[i].script.name.if_null[<[i].material.name>]>].exclude[<player.held_item_slot>]>
            - if <[slots].any>:
                - define random_slot <[slots].random>
                - inventory set o:<[inv].slot[<[random_slot]>]> d:<[inv]> slot:<player.held_item_slot>
                - inventory set o:air slot:<[random_slot]> d:<[inv]>
                - narrate "<&7>Your <&e><[i].display.if_null[<[i].material.translated_name>]><&7> has broken and was replaced with another."