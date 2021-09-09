<!-- Event APIs -->

## on\_name\_change

This function tag will get called when a player's name has changed in the system. Note, PlayerDB will only start tracking name changes when it's added so if a player has not joined and changed their name, PlayerDB will not be able to track that. It automatically transfers PlayerDB data but now you can transfer scores and more.

```yaml
// @function_tag rx.playerdb:api/v2/event/on_name_change
{}
```

## on\_entry\_add

This function tag will get called when an entry is created. This allows you to dynamically setup an entry without explictly calling `api/get_self` for every player that joins your world / server. You must make sure to not call any api functions to avoid loops.

```yaml
// @function_tag rx.playerdb:api/v2/event/on_entry_add
{}
```
