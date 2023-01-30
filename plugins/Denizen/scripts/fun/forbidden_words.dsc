get_forbidden_word:
    type: procedure
    debug: false
    definitions: item|should_exist
    script:
    - if <[should_exist]> and not <server.has_flag[forbidden_words]>:
        - determine null
    - if <[item].material.name> != diamond or !<[item].has_display>:
        - determine null
    - define word <[item].display.strip_color.to_lowercase.before[ ]>
    - if <server.flag[forbidden_words].contains[<[word]>].if_null[false]> == <[should_exist]>:
        - determine <[word]>
    - determine null

forbidden_words:
    type: world
    debug: false
    events:
        on entity damaged by lava type:dropped_item:
        - ratelimit <context.entity> 3t
        - define item <context.entity.item>
        - define word <[item].proc[get_forbidden_word].context[false]>
        - if <[word]> == null:
            - stop
        - flag server forbidden_words:->:<[word]>
        - customevent id:forbidden_word_created context:[word=<[word]>]
        after player empties water_bucket:
        - define diamonds <context.relative.find_entities[dropped_item].within[1.5]>
        - if <[diamonds].is_empty>:
            - stop
        - define diamond <[diamonds].first>
        - define word <[diamond].item.proc[get_forbidden_word].context[true]>
        - if <[word]> == null:
            - stop
        - flag server forbidden_words:<-:<[word]>
        - modifyblock <context.relative> air
        - customevent id:forbidden_word_removed context:[word=<[word]>;location=<[diamond].location>]
        - remove <[diamond]>
        on player chats:
        - define words <context.message.split[ ].shared_contents[<server.flag[forbidden_words]>]>
        - if <[words].is_empty>:
            - stop
        - determine passively cancelled
        - define noun word<[words].size.is_more_than[1].if_true[s].if_false[<empty>]>
        - customevent id:forbidden_words_used context:[words=<[words]>;noun=<[noun]>]

forbidden_words_listeners:
    type: world
    debug: false
    events:
        after custom event id:forbidden_word_created:
        - announce "<&[emphasis]>➞ '<&[base]><context.word><&[emphasis]>' is now a <red><italic><bold>FORBIDDEN WORD!"
        - playsound <server.online_players> sound:entity_wither_spawn sound_category:master
        after custom event id:forbidden_word_removed:
        - playeffect effect:smoke at:<context.location> quantity:10
        - playsound <context.location> sound:block_fire_extinguish sound_category:block
        - announce "<&[emphasis]>➞ The forbidden word '<&[base]><context.word><&[emphasis]>' has been <aqua><italic><bold>PURIFIED!"
        - playsound <server.online_players> sound:entity_player_levelup sound_category:master
        after custom event id:forbidden_words_used:
        - strike <player.location>
        - define formatted_words <context.words.parse_tag[<red><bold><strikethrough><[parse_value].strip_color><&[emphasis]>]>
        - announce "<&[emphasis]>➞ <player.display_name> has muttered the <context.noun>: <[formatted_words].separated_by[, ]>!"

forbidden_words_counters:
    type: world
    events:
        #after custom event id:forbidden_word_created:
        #- flag <player> forbidden_word_counts.created:++
        after custom event id:forbidden_word_removed:
        - flag <player> forbidden_word_counts.removed:++
        after custom event id:forbidden_words_used:
        - flag <player> forbidden_word_counts.used:+:<context.words.size>