discord_bridge:
    type: world
    events:
        after player chats:
        - discordmessage id:bot channel:1069156072197210112 "`<player.name>`: <context.message>"
        after discord message received channel:1069156072197210112:
        - if not <context.new_message.author.is_bot>:
            - announce "<italic><gray><&lt><&color[#7388d9]><context.new_message.author.name><gray><&gt> <context.new_message.text>"
        after player join:
        - discordmessage id:bot channel:1069156072197210112 "<&gt> *<player.name> joined*"
        after player quit:
        - discordmessage id:bot channel:1069156072197210112 "<&gt> *<player.name> left*"
