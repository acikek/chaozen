clippy_connect:
    type: world
    debug: false
    events:
        after server start:
        - discordconnect id:bot token:discord_token

clippy_commands:
    type: task
    debug: false
    script:
    - ~run clippy_leaderboard_command

clippy_yay:
    type: world
    debug: false
    events:
        after discord message received message:*yay*:
            - if <context.new_message.author.is_bot>:
                - ~discordmessage id:bot "+<&gt> YAY!!!" channel:<context.channel>
