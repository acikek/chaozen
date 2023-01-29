# -------------------------------------------------- #
# Script: toolreplace
# Author: LG_Legacy (84366968383082496)
# Date: 1/29/2023
# -------------------------------------------------- #

toolreplace_cmd:
    type: command
    name: toolreplace
    aliases:
        - tr
    description: Toggles the broken tool replacement feature.
    usage: /toolreplace
    script:
        - if <player.has_flag[toolreplace_disabled]>:
            - flag <player> toolreplace_disabled:!
            - narrate "<&7>You have <&a>enabled<&7> the tool replacement feature."
        - else:
            - flag <player> toolreplace_disabled
            - narrate "<&7>You have <&c>disabled<&7> the tool replacement feature."

toolreplace_events:
    type: world
    debug: false
    events:
        after player breaks held item:
            - if !<player.has_flag[toolreplace_disabled]>:
                - define i <context.item>
                - define inv <player.inventory>
                - define slots <[inv].find_all_items[<[i].material.name>].filter_tag[<[inv].slot[<[filter_value]>].script.exists.not>]>
                - define slots <[inv].find_all_items[<[i].script.name>].filter_tag[<[inv].slot[<[filter_value]>].script.name.equals[<[i].script.name>]>]> if:<[i].script.exists>
                - if <[slots].any>:
                    - define random_slot <[slots].random>
                    - inventory set o:<[inv].slot[<[random_slot]>]> d:<[inv]> slot:<player.held_item_slot>
                    - inventory set o:air slot:<[random_slot]> d:<[inv]>
                    - narrate "<&7>Your <&e><[i].display.if_null[<[i].material.translated_name>]><&7> has broken and been replaced with another."