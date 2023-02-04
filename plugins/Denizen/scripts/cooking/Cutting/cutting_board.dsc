######### NOTICE: IN PROGRESS (DEBUGGING IS STILL IN)

cutting_board:
    type: item
    display name: <&f>Cutting Board
    material: oak_slab

cutting_board_handle:
    type: world
    debug: true
    events:
        on player right clicks block with:cutting_board:
            - determine passively cancelled
            - ratelimit <player> 10t
            - stop if:<context.location.has_flag[cooking.cutting_board]>
            - define loc <context.location.above[1]>

            - take slot:hand
            - modifyblock <[loc]> oak_pressure_plate
            - spawn armor_stand[visible=false;gravity=false;invulnerable=true;marker=true] <[loc].center.relative[0,-1.2,0].backward_flat[1]> save:teleport_stand
            - flag <[loc]> cooking.cutting_board:<entry[teleport_stand].spawned_entity>

        on player right clicks block location_flagged:cooking.cutting_board with:item_flagged:cooking_knife priority:-1:
            - ratelimit <player> 10t
            - teleport <player> <context.location.flag[cooking.cutting_board].location>
        on player right clicks block location_flagged:cooking.cutting_board:
            - determine passively cancelled
            - ratelimit <player> 10t
            - define item <context.item>
            - stop if:<[item].has_flag[cooking_knife]>
            - if <[item].material.name> == air:
                - give <context.location.flag[cooking.showing].flag[cooking.held_item]> quantity:1
                - remove <context.location.flag[cooking.showing]>
                - flag <context.location> cooking.showing:!
                - stop
            - stop if:<context.location.has_flag[cooking.showing]>
            - take slot:hand quantity:1
            - spawn armor_stand[visible=false;gravity=false;invulnerable=true;is_small=true;arms=true;armor_pose=right_arm|3.16,0,0;disabled_slots=[HAND=ALL|REMOVE]] <context.location.center.relative[0.2,-1.4,0.1]> save:display
            - flag <entry[display].spawned_entity> cooking.held_item:<[item]>
            - flag <context.location> cooking.showing:<entry[display].spawned_entity>
            - equip <context.location.flag[cooking.showing]> hand:<[item]>
        on player breaks block location_flagged:cooking.cutting_board:
            - flag <context.location> cooking.cutting_board:!
            - determine passively cutting_board
        on player breaks block location_flagged:!cooking.cutting_board:
            - if <context.location.above[1].has_flag[cooking.cutting_board]>:
                - determine passively cancelled
        on player right clicks block location_flagged:!cooking.cutting_board:
            - if <context.location.above[1].has_flag[cooking.cutting_board]>:
                - determine passively cancelled

