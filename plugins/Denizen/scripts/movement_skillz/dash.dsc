# A dash activated by sneaking twice in quick succession.



# Flags:
# can_dash:
#   This flag is for when the player just crouched and is eligible to perform a dash.


dash_handler:
    type: world
    data:
        # Self explanatory
        cooldown_between_dashes: 1s
        # How much time the player has to perform the dash before it's too late
        time_to_dash: 0.5s
        # This basically indicates how fast the dash will be and how far it will go
        vector_multiplicator: 2
    debug: false
    events:
        after player stops sneaking flagged:!second_sneak|!can_dash|!on_dash_cooldown:
        - flag <player> on_dash_cooldown expire:<script.data_key[data.cooldown_between_dashes]>
        - flag <player> second_sneak expire:<script.data_key[data.time_to_dash]>
        after player stops sneaking flagged:second_sneak|!can_dash:
        - flag <player> second_sneak:!
        - flag <player> can_dash expire:<script.data_key[data.time_to_dash]>
        after player walks flagged:can_dash:
        - ratelimit <player> 2t
        # Checks if the player actually moved
        - if <context.old_location.distance[<context.new_location>]> != 0:
            - flag <player> can_dash:!
            - adjust <player> velocity:<context.new_location.sub[<context.old_location>].normalize.mul[<script.data_key[data.vector_multiplicator]>]>
            - flag <player> dash_particles expire:0.2s
        after player walks flagged:dash_particles:
        - ratelimit <player> 1t
        - playeffect effect:vibration at:<context.old_location.above> quantity:10 offset:0.2 special_data:2t|<context.old_location.above>|<context.new_location.above>