clippy_leaderboard_command:
    type: task
    script:
    - definemap options:
        1:
            type: string
            name: type
            description: The leaderboard to display
            required: true
            choices:
                1:
                    name: Forbidden Words
                    value: forbidden
    - ~discordcommand id:bot create group:1069152111796957194 name:leaderboard "description:Various user rankings" options:<[options]>

clippy_leaderboard_format:
    type: procedure
    definitions: player
    script:
    - determine "**<[player].display_name>**: **<[player].flag[forbidden_word_counts.used].if_null[0]>** used, **<[player].flag[forbidden_word_counts.removed].if_null[0]>** removed"

clippy_leaderboard_handler:
    type: world
    events:
        on discord slash command name:leaderboard:
        - discordinteraction defer interaction:<context.interaction>
        - choose <context.options.get[type]>:
            - case forbidden:
                - define created "There are **<server.flag[forbidden_words].size>** forbidden words: <server.flag[forbidden_words].parse_tag[*<[parse_value]>*].formatted>"
                - define users <server.players_flagged[forbidden_word_counts].parse[proc[clippy_leaderboard_format]].separated_by[<n>]>
                - discordinteraction reply interaction:<context.interaction> "<[created]><n><n><[users]>"