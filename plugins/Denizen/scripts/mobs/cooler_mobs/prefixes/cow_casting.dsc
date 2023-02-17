mob_mod_cow_casting:
    type: world
    debug: false
    mob_modifier:
        type: prefix
        weight: 0.01
    events:
        after entity_flagged:mob_modifiers.cow_casting added to world:
            - wait 3m
            - stop if:<context.entity.is_spawned.not>
            - while <context.entity.exists>:
                - spawn <entity[cow].with[custom_name=<proc[mob_modifiers_cow_casting_get_random_cow_name]>;custom_name_visible=true]> at:<context.entity.location> quantity:1
                - wait 10m

mob_modifiers_cow_casting_get_random_cow_name:
    type: procedure
    debug: false
    data:
        - Jeremiah
        - Call the priest! This mob summons cows!
        - How the hell did I get here?!?!?!?
        - Ground beef haha
        - If you're reading this, you're a nerd
        - Moorific
        - Moo
        - Moo moo
        - Moo moo moo
        - My name is Jeremiah and I am scared
        - I am not meant to be here
        - help
        - A lack of better judgement!
        - Please help me
        - qwerty
        - Professional cheese maker
        - Trans rights!
        - Mr. Beast
        - Mr. Beast but if he was evil
        - Mr. Beast but if he was a cow
        - Mr. Beast but if he was a cow and evil
        - oh for fucks sake
        - leave me alone
        - I am not a cow I am a C.I.A. agent
        - help me escape from this flesh prison
        - I have no fucking clue what I'm doing
        - Kill me if you can coward
        - there's a chance this message will never appear
        - you should buy my merch
        - https://github.com/acikek/chaozen
        - - kill <&lt>player<&gt>
        - i listen to classical music
        - ok and I asked when
        - I'm not a cow I'm a human! help me!
        - i hate json so much
        - horrifying implications, have a bad day
        - what the fuck
        - contribute to chaozen you cowards
        - please dont eat me i am actually a 15th century monarch
        - please do eat me i am a tasty creature
        - i am so fucking scared right now you shut up
        - i hope you explode randomly
    script:
        - determine <script.data_key[data].random>