integerize:
    type: procedure
    definitions: list[list of decimals and/or integers you want to convert to integers]
    script:
        # Returns an empty list if the list is empty
        - determine <list> if:<[list].any.not>
        # Returns an empty list if the list contains any non-numbers
        - determine <list> if:<[list].filter_tag[<[filter_value].is_decimal.not>].any>
        # Returns the list if the list is already all integers
        - determine <[list]> if:<[list].filter_tag[<[filter_value].is_integer.not>].any.not>
        # Foreach number in the list, multiply it by 10 until all are integers
        - while <[list].filter_tag[<[filter_value].is_integer.not>].any>:
            - define iteration_list <list>
            - foreach <[list]>:
                - define iteration_list:->:<[value].mul[10]>
            - define list <[iteration_list]>
        - determine <[list]>
