# A small script to reload 3 seconds after the server starts, that way we only have to use the script reload event instead of using that an server start event.

reload_after_start:
    type: world
    events:
        after server starts:
            - wait 3s
            - reload