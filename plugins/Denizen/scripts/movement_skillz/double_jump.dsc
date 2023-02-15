# Double jump!!!!!!!!!!!!! But you actually have to jump three times because fuck you
# You can only jump in water if you touch the ground because it doesn't trigger the player jumps event otherwise :P



# Flags:
# capable_to_double_jump:
#   Without this flag, you cannot double jump. It's pretty much here just to prevent everyone from doing it lel
#   Can be added in specific scenarios or toggled with the '/doublejump toggle' command.
#
# can_double_jump:
#   This flag is for when the player just jumped and is eligible to perform a double jump.
#
# double_jump_verticality:
#   Determines if the double jump will take verticality into account or not.
#   Can be toggled with the '/doublejump verticality'


double_jump_handler:
    type: world
    data:
        # How much time the player has to perform the double jump before it's too late
        time_to_jump: 0.5s
        # This basically indicates how far you'll go with the double jump
        vector_multiplier: 2
        # multiplier of the vector in case of verticality. Meant to prevent it from being too OP.
        verticality_multiplier: 0.7
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
        - if <player.has_flag[double_jump_verticality]>:
            # If vertical, uses half of vector multiplier to not be so broken
            - adjust <player> velocity:<player.location.direction.vector.normalize.mul[<script.data_key[data.vector_multiplier]>].mul[<script.data_key[data.verticality_multiplier]>]>
        - else:
            # inb4 'why .forward_flat[5]????': arbitrary number
            - adjust <player> velocity:<player.location.forward_flat[5].sub[<player.location>].normalize.mul[<script.data_key[data.vector_multiplier]>]>



doublejump_command:
    type: command
    name: doublejump
    description: Manages your double jumping.
    usage: /doublejump [toggle | verticality]
    tab completions:
        1: toggle|verticality
    debug: false
    script:
    - if <context.args.is_empty>:
        - narrate "<&[error]>Incorrect usage!"
        - narrate <&[emphasis]><script.data_key[usage]>
        - narrate <&[base]><script.data_key[description]>
        - stop
    - if <context.args.size> > 1:
        - narrate "<&[error]>Too many arguments!"
        - narrate <&[emphasis]><script.data_key[usage]>
        - stop

    - choose <context.args.first>:
        - case toggle:
            - if <player.has_flag[capable_to_double_jump]>:
                - flag <player> capable_to_double_jump:!
                - narrate "<&[emphasis]>Double Jump toggled off."
            - else:
                - flag <player> capable_to_double_jump
                - narrate "<&[emphasis]>Double Jump toggled on."
        - case verticality:
            - if <player.has_flag[double_jump_verticality]>:
                - flag <player> double_jump_verticality:!
                - narrate "<&[emphasis]>Double jump verticality turned off."
            - else:
                - flag <player> double_jump_verticality
                - narrate "<&[emphasis]>Double jump verticality turned on."
                - narrate "<&[warning]>While on verticality mode, your double jumps will have a <script[double_jump_handler].data_key[data.verticality_multiplier]>x jump force."
        - default:
            - narrate "<&[error]>Unknown argument!"
            - narrate <&[emphasis]><script.data_key[usage]>