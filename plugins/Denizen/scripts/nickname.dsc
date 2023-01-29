apply_nickname:
  type: task
  debug: false
  definitions: name
  script:
  - adjust <player> display_name:<[name]>'
  - adjust <player> name:<[name]>
  - adjust <player> player_list_name:<[name]>'
nickname_command:
  type: command
  name: nickname
  aliases:
  - nick
  - name
  usage: /nickname (name|remove)
  description: Allows you to set a nickname for yourself that will be shown instead of your username.
  script:
  - if <context.args.size> != 1:
    - narrate "<&[ue]>Please provide exactly one argument. Use /help nickname for format."
    - stop
  - define name <context.args.get[1].parse_color>
  - if <[name]> == remove:
    - narrate "<&[base]>Nickname removed!"
    - stop
  - if <[name].length> < 3 || <[name].length> > 16:
    - narrate "<&[ue]>Please choose a name of reasonable length. Must be between 3 and 16 characters."
    - stop
  - if <[name].trim_to_character_set[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]> == <empty>:
    - narrate "<&[ue]>Your name must contain at least one letter."
    - stop
  - if <[name].contains[<&k>]>:
    - narrate "<&[ue]>Please don't use '&k' within your nickname."
    - stop
  - flag <player> nickname:<[name]>
  - run apply_nickname def:<[name]>
  - narrate "<&[base]>Nickname set to <&[emphasis]><[name]><&r><&[base]>!"
realname_command:
  type: command
  name: realname
  usage: /realname (nickname)
  description: Shows you who has the nickname you input.
  script:
  - if <context.args.size> != 1:
    - narrate "<&[ue]>Please provide exactly one argument. Use /help realname for format."
    - stop
  - foreach <server.players>:
    - if <player.flag[nickname].strip_color.if_null[<empty>]> == <context.args.get[1]>:
      - narrate "<&[emphasis]><context.args.get[1]><&r><&[base]> is <&[emphasis]><[value].name><&[base]>."
      - stop
  - narrate "<&[base]>Nobody has that nickname. Double-check your spelling!"
reset_nickname:
  type: world
  debug: false
  events:
    on player joins flagged:nickname:
    - run apply_nickname def:<player.flag[nickname]>

