player_restraints:
    type: world
    debug: false
    events:
        on player walks flagged:util.nowalk:
            - determine passively cancelled
        on player steps on block flagged:util.nostep:
            - determine passively cancelled
        on player dies flagged:util.nodie:
            - determine passively cancelled
        on player damaged by FALL flagged:util.nofall:
            - determine passively cancelled
        on player damaged flagged:util.nodamage:
            - determine passively cancelled