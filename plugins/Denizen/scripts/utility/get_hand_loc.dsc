get_hand_loc:
    type: procedure
    definitions: player
    debug: false
    script:
        - if <[player].main_hand> == RIGHT:
            - define tyr <[player].location.right[0.4]>
        - else:
            - define tyr <[player].location.left[0.4]>
        - determine <[tyr]>