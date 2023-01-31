# If the player's uuid matches a random uuid, bans them lmao

lottery_ban_handler:
    type: world
    data:
        message: Won the ban lottery. Your UUID matched a random one. That's a one in a quintillion chance or something. Good job! Get perma'd (IP too)
    debug: false
    events:
        on player joins flagged:!lottery_ban_already_joined:
        - if <player.uuid> == <util.random_uuid>:
            - ban <player> reason:<script.data_key[data.message]>
            - ban addresses:<player.ip> reason:<script.data_key[data.message]>
        - else:
            - flag <player> lottery_ban_already_joined