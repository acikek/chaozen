# This file is for prefixes that take up less than 20 lines of code. If you have a prefix that takes up more than 20 lines of code, please make a new file for it.
# This includes the entire script container, not just the script itself.

mob_mod_speedy:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 1
    events:
        after entity_flagged:mob_modifiers.speedy spawns:
            - adjust <context.entity> speed:<context.entity.speed.mul[1.5]>

mob_mod_shellback:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 1
    events:
        after entity_flagged:mob_modifiers.shellback spawns:
            - run shelled_add def.entity:<context.entity> def.amount:5

mob_mod_regenerating:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 100
    events:
        after entity_flagged:mob_modifiers.regenerating damaged:
            - stop if:<context.entity.is_spawned.not>
            - cast regeneration <context.entity> amplifier:2 duration:<util.random.int[3].to[10]>s
            - playeffect at:<context.entity.eye_location> quantity:50 effect:villager_happy offset:0.5,0.5,0.5

mob_mod_venomous:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 1
    events:
        after entity damaged by entity_flagged:mob_modifiers.venomous:
            - cast <list[poison|wither].random> <context.entity> amplifier:2 duration:5s

mob_mod_enhanced:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 0.1
    events:
        after entity_flagged:mob_modifiers.enhanced spawns:
            - adjust <context.entity> speed:<context.entity.speed.mul[1.35]>
            - adjust <context.entity> max_health:<context.entity.health_max.mul[1.35]>
            - heal <context.entity>
        on entity damaged by entity_flagged:mob_modifiers.enhanced:
            - determine <context.damage.mul[1.35]>

mob_mod_crushing:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 0.1
    events:
        after entity damaged by entity_flagged:mob_modifiers.crushing:
            - playsound <context.entity.eye_location> sound:entity_zombie_villager_cure volume:1.5 pitch:2
            - hurt <context.entity.effects_data.size.div[3]> <context.entity> source:<context.entity>
            - cast slow <context.entity> amplifier:2 duration:10s
            - cast weakness <context.entity> amplifier:2 duration:10s

mob_mod_porcupining:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 0.1
    events:
        on entity damaged by entity_flagged:mob_modifiers.porcupining:
            - determine <context.damage.mul[<context.entity.flag[stats.hit_by_projectile.arrow].if_null[0].mul[0.1].add[1]>]>

mob_mod_breaking:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 1
    events:
        after player damaged by entity_flagged:mob_modifiers.breaking:
            - if <player.item_in_hand> matches shield or <player.item_in_offhand> matches shield:
                - itemcooldown <material[shield]> duration:5s
                - playsound <player.location> sound:entity_item_break volume:1.5 pitch:0.5

mob_mod_radiating:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 1
    events:
        after entity_flagged:mob_modifiers.radiating added to world:
            - while <context.entity.exists>:
                - cast poison <context.entity.location.find.living_entities[!monster].within[10].exclude[<context.entity>]> duration:5s amplifier:0
                - wait 2s

mob_mod_tracking:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 1
    events:
        after entity_flagged:mob_modifiers.tracking added to world:
            - while <context.entity.exists>:
                - attack <context.entity> target:<context.entity.find_players_within[100].first>

mob_mod_vampiric:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 1
    events:
        after entity damaged by entity_flagged:mob_modifiers.vampiric:
            - heal <context.damager> amount:<context.damage.div[2]>