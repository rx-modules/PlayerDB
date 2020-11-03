# Lag Testing

### General Lag Testing (03 Nov 2020)

I put on some heavy load to test the generic tps lag from calling the library every tick. This image is testing a 3.1mb storage file (5 copies of player nbt w/ all recipes unlocked on 50 entries). There are 10-20 players online (carpet players) and there is a command block calling `api/get_self` for a random set of 10 players.

![result](nov3/10-random-calls)

While there is definitely an easy to see load, most of the processing is actually spent on the copy to `rx:io`. Since we have a ton of data stored, this results in noticable lag.

I continued to test a select-save versus a get-save as a comparision of understanding the impact of copying in and out of `rx:io`. I tested under numerous loads such as 3.1mb and 21kb storage nbt files.

	execute as @a[sort=random,limit=10] run function rx.playerdb:test/pdb/get_save(105/1) - 59.58%/3.63%

	execute as @a[sort=random,limit=10] run function rx.playerdb:test/pdb/select_save(105/1) - 35.12%/2.14%


*check out full debug file [here](nov3/get_vs_select.txt)*

Generally, the pack feels pretty light and squeaky. I think array iteration seems a lot simpler and for small cases, it's probably not worth grabbing PlayerDB. However, once you start adding many entries or large amounts of data, the lag starts scaling pretty high. For EnderChest+, this would be extremely clumbersome since opening the EnderChest+ puts a manual in your enderchest (which is a pretty lengthy item). If every player where to have their manual stored in their enderchest, then the system would get laggy very fast if we were using array iteration.


### Preliminary Lag Results (07 Oct 2020)

EntityDB vs PlayerDB vs EnderChests

I'll have to write more here when I do another test run but I've included some results of a debug profiler report. Note, that profile reports **don't** describe the full story. Especially with profiling w/ data storage techniques, the data being stored and the amount of players/entities being called matters quite a bit.

In the following .txt file, you'll wanna pay attention to these lines (higher numbers are bad):

    [01] |   /execute as @a run function rx.playerdb:test/entitydb/get_save(1/0) - 0.57%/0.48%

    [01] |   /execute as @a run function rx.playerdb:test/echest/get_save(1/0) - 0.53%/0.45%

    [01] |   /execute as @a run function rx.playerdb:test/modify_save(1/0) - 0.42%/0.35%

*note, all the functions have `test` since I wrote some commands to wrap various methods of a get/save operation*
