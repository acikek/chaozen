snake_case_to_title_case:
    type: procedure
    description: Converts a snake_case element to title case.
    definitions: element[snake_case element you wish to convert to title case]
    script:
        - determine <[element].replace[_].with[ ].to_titlecase>