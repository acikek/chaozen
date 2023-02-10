snake_case_to_spaced_title_case:
    type: procedure
    debug: false
    description: Converts a snake_case element to Spaced Title Case.
    definitions: element[snake_case element you want to convert to Spaced Title Case]
    script:
        - determine <[element].replace[_].with[ ].to_titlecase>