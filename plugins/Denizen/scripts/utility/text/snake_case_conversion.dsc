snake_case_to_title_case:
    type: procedure
    definitions: element[snake_case element you wish to convert to title case]
    script:
        - determine <[element].replace[_].with[ ].to_titlecase>