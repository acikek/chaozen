####################################
####      Made by: Daxzies      ####
####        Get Hand Loc        ####
####################################
####   Gets the player's hand   ####
####          location          ####
####################################



get_hand_loc:
    type: procedure
    definitions: player
    debug: false
    script:
        - define hand <[player].main_hand>
        - if <[player].main_hand> == RIGHT:
            - define tyr <[player].location.right[0.4]>
        - else:
            - define tyr <[player].location.left[0.4]>
        - determine <[tyr]>
