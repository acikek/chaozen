get_random_item_from_weighted_map:
    type: procedure
    debug: false
    description:
        - Gets a random item from a map of keys (the items (doesn't have to be an actual item) to select from) and values (the weights of the items).
        - Example: <map[diamond_sword=1;stone=5]>
    definitions: map[map of keys with the values being the weight of the key]
    script:
        - define integerized_map <map>
        # Ensure all the weights are integers.
        - foreach <[map]> as:weight key:item:
            - define integerized_map <[integerized_map].with[<[item]>].as[<[weight].proc[integerize]>]>
        # Redefine the map with the integerized weights.
        - define map <[integerized_map]>
        # Get a random number between 0 and the total weight.
        - define total 0
        - foreach <[map]> as:weight key:item:
            - define total:+:<[weight]>
        - define random <util.random.int[0].to[<[total]>]>
        - define current 0
        - foreach <[map].sort_by_value.reverse> as:weight key:item:
            - define current:+:<[weight]>
            # If the current weight is greater than or equal to the random number, return the item.
            - if <[current]> >= <[random]>:
                - determine <[item]>
