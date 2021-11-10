<!-- Various Messages -->

# API Error Messages

<details>

`@message rx.playerdb:load`
```json
[{"text":"", "color":"gray"}, {"nbt": "playerdb.pretty_name", "storage": "rx:info", "interpret": true}, " ", {"storage": "rx:info", "nbt": "playerdb.pretty_version", "interpret": true}, " loaded"]
```

`@allay_message rx.playerdb:error/no_data`

```
{nbt="playerdb.name", storage="rx:info"} [Save Error: No rx:io data to save](#CE4257)
```

`@allay_message rx.playerdb:error/bad_uid`
```
{nbt="playerdb.name", storage="rx:info"} [Error: rx.playerdb:io player.info.uid invalid](#CE4257)
```

`@allay_message rx.playerdb:error/empty_database`
```
{nbt="playerdb.name", storage="rx:info"} [Select Error: Selection failed. No players in database to select](#CE4257)
```

`@allay_message rx.playerdb:error/impossible_uid`
```
{nbt="playerdb.name", storage="rx:info"} [Get Error: Input uid above max uid](#CE4257)
```

</details>

# Admin Messages

<details>

`@allay_message rx.playerdb:admin/impossible_uid`
```
{nbt="playerdb.name", storage="rx:info"} [Deletion Error: Input uid outside max uid](#CE4257)
```

`@allay_message rx.playerdb:admin/successful_removal`
```
{nbt="playerdb.name", storage="rx:info"} [Removal Success: Removed {nbt="players[{selected:1b}.info.name]", storage="rx.playerdb:main"}'s entry](#1DF368)

[→ Don't forget to reset their rx.playerdb.has_entry score \(unless you ran admin/delete_player\)](gold)
```

`@allay_message rx.playerdb:admin/non_existent_entry`
```
{nbt="playerdb.name", storage="rx:info"} [Removal Error: Entry does not exist](#CE4257)
```

`@allay_message rx.playerdb:admin/migration/bad_input`
```
{nbt="playerdb.name", storage="rx:info"} [Migration Error: Bad input at](#CE4257) [rx.playerdb:temp admin.migrate](gold) [is empty](#CE4257)
```

`@allay_message rx.playerdb:admin/migration/acc_not_found`
```
{nbt="playerdb.name", storage="rx:info"} [Migration Error: Input UUID account not found](#CE4257)
```

`@allay_message rx.playerdb:admin/migration/success`
```
@insert = (insertion="/scoreboard players reset ")

#ALLAYDEFS

{nbt="playerdb.name", storage="rx:info"} [Migration Success:](#1DF368) {nbt="admin.migrate.old_name", storage="rx.playerdb:temp"}(gold)['s data was migrated to](#1DF368) {@s}(gold)

[→ Run ](gray) [/scoreboard players reset {nbt="admin.migrate.old_name", storage="rx.playerdb:temp"}](gold, @insert) [to complete the migration process!](gray)
```

`@allay_message rx.playerdb:admin/migration/success_to_migrated`
```
{nbt="playerdb.name", storage="rx:info"} [Migration Success:](#1DF368) {nbt="admin.migrate.old_name", storage="rx.playerdb:temp"}(gold)['s data was successfully migrated to you!](#1DF368)
```

`@allay_message rx.playerdb:admin/reset`
```
{nbt="playerdb.name", storage="rx:info"} [Reset Success: PlayerDB successfully reset](#1DF368)
```

</details>

# Misc Messages

<details>

`@allay_message rx.playerdb:api/name_change`
```
{nbt="playerdb.name", storage="rx:info"} {nbt="old_name", storage="rx.playerdb:io"}(gold) [has changed their name to](#1DF368) {@s}(gold)
```

`@allay_message rx.playerdb:upgrade/v1tov2`
```
{nbt="playerdb.name", storage="rx:info"} [Upgrade Success: PlayerDB v1 upgraded to v2](#1DF368)
```

`@allay_message rx.playerdb:upgrade/v1tov2/player`
```
{nbt="playerdb.name", storage="rx:info"} [Upgrade Success: Your data has been safely transfered :)](#1DF368)
```

</details>