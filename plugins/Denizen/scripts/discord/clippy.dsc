clippy_connect:
    type: world
    events:
        after server start:
        - discordconnect id:bot token:discord_token

clippy_commands:
    type: task
    script:
    - ~run clippy_leaderboard_command