# Testing

I'll have to write more here when I do another test run but I've included some results of a debug profiler report. Note, that profile reports **don't** describe the full story. Especially with profiling w/ data storage techniques, the data being stored and the amount of players/entities being called matters quite a bit.

In the following .txt file, you'll wanna pay attention to these lines:

    [01] |   /execute as @a run function rx.playerdb:test/entitydb/get_save(1/0) - 0.57%/0.48%

    [01] |   /execute as @a run function rx.playerdb:test/echest/get_save(1/0) - 0.53%/0.45%

    [01] |   /execute as @a run function rx.playerdb:test/modify_save(1/0) - 0.42%/0.35%

*note, all the functions have `test` since I wrote some commands to wrap various methods of a get/save operation*
