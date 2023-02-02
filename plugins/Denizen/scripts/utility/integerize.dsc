integerize:
    type: procedure
    description: Multiplies a decimal or integer by 10 until it is an integer.
    definitions: element[decimal/integer you want to convert to an integer]
    script:
        - determine 0 if:<[element].is_decimal.not>
        - determine <[element]> if:<[element].is_integer>
        - while <[element].is_integer.not>:
            - define element:*:10
        - determine <[element]>

integerize_list:
    type: procedure
    description: Multiplies a list of decimals and/or integers by 10 until all are integers.
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
