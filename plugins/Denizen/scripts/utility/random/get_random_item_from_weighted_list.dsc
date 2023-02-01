get_random_item_from_weighted_map:
    type: procedure
    definitions: map[map of keys with the values being the weight of the key]
    script:
        - foreach <[map]> as:weight key:item:
            - define integerized_map <[map].with[<[item]>].as[<list_single[<[weight]>].proc[integerize].first>]>
        - define map <[integerized_map]>
        - define total 0
        - foreach <[map]> as:weight key:item:
            - define total:+:<[weight]>
        - define random <util.random.int[0].to[<[total]>]>
        - define current 0
        - foreach <[map].sort_by_value.reverse> as:weight key:item:
            - define current:+:<[weight]>
            - if <[current]> >= <[random]>:
                - determine <[item]>
