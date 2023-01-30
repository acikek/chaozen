sum_list:
    type: procedure
    description: Adds together a list of decimals and returns the sum.
    definitions: list[list of decimals to add together]
    script:
        - define sum 0
        - foreach <[list]> as:<[num]>:
            - define sum <[sum]>:+:<[num]>
        - determine <[sum]>