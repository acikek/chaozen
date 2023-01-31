# Double jump!!!!!!!!!!!!! But you actually have to jump three times because fuck you
# You can only jump in water if you touch the ground because it doesn't trigger the player jumps event otherwise :P



# Flags:
# capable_to_double_jump:
#   Without this flag, you cannot double jump. It's pretty much here just to prevent everyone from doing it lel
#   Can be added in specific scenarios or toggled with the /toggledoublejump command.
#
# can_double_jump:
#   This flag is for when the player just jumped and is eligible to perform a double jump.


double_jump_handler:
    type: world
    data:
        # How much time the player has to perform the double jump before it's too late
        time_to_jump: 0.5s
        # This basically indicates how far you'll go with the double jump
        vector_multiplicator: 2
        # Chooses whether to use .forward_flat or .direction.vector. One launches you straight forward while the other takes in user vertical input,
        # meaning you could double jump directly upwards if you looked to the sky.
        ## WILL STILL TAKE FALL DAMAGE!
        verticality: false
    debug: false
    events:
        after player jumps flagged:capable_to_double_jump|!can_double_jump:
        - adjust <player> can_fly:true
        - flag <player> can_double_jump expire:<script.data_key[data.time_to_jump]>
        - wait <script.data_key[data.time_to_jump]>
        - adjust <player> can_fly:false

        after player toggles flying flagged:can_double_jump:
        - flag <player> can_double_jump:!
        - adjust <player> flying:false
        - if <script.data_key[data.verticality]>:
            - adjust <player> velocity:<player.location.direction.vector.normalize.mul[<script.data_key[data.vector_multiplicator]>]>
        - else:
            # inb4 'why .forward_flat[5]????': arbitrary number
            - adjust <player> velocity:<player.location.forward_flat[5].sub[<player.location>].normalize.mul[<script.data_key[data.vector_multiplicator]>]>



toggledoublejump_command:
    type: command
    name: toggledoublejump
    description: Toggles your capability of double jumping.
    usage: /toggledoublejump
    script:
    - if !<context.args.is_empty>:
        - narrate "<&[error]>Too many arguments!"
        - narrate <&[emphasis]><script.data_key[usage]>
        - narrate <&[base]><script.data_key[description]>
        - stop

    - if <player.has_flag[capable_to_double_jump]>:
        - flag <player> capable_to_double_jump:!
        - narrate "<&[emphasis]>Double Jump toggled off."
    - else:
        - flag <player> capable_to_double_jump
        - narrate "<&[emphasis]>Double Jump toggled on."