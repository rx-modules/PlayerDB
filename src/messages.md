<!-- Various Messages -->

# API Error Messages

<details>

`@allay_message rx.playerdb:load`
```
{$pretty_name} {storage="rx:info", nbt="playerdb.pretty_version", interpret}(@normal) [loaded](@normal)
```

`@allay_message rx.playerdb:error/no_data`
```
{$pretty_name} [Save Error: No rx:io data to save](@error)
```

`@allay_message rx.playerdb:error/bad_uid`
```
{$pretty_name} [Error: rx.playerdb:io player.info.uid invalid](@error)
```

`@allay_message rx.playerdb:error/empty_database`
```
{$pretty_name} [Select Error: Selection failed. No players in database to select](@error)
```

`@allay_message rx.playerdb:error/impossible_uid`
```
{$pretty_name} [Get Error: Input uid above max uid](@error)
```

</details>

# Admin Messages

<details>

`@allay_message rx.playerdb:admin/impossible_uid`
```
{$pretty_name} [Deletion Error: Input uid outside max uid](@error)
```

`@allay_message rx.playerdb:admin/successful_removal`
```
{$pretty_name} [Removal Success: Removed {nbt="players[{selected:1b}].info.name", storage="rx.playerdb:main"}'s entry](@success)

[→ Don't forget to reset their rx.pdb.has_entry score \(unless you ran admin/delete_player\)](@emphasis)
```

`@allay_message rx.playerdb:admin/non_existent_entry`
```
{$pretty_name} [Removal Error: Entry does not exist](@error)
```

`@allay_message rx.playerdb:admin/migration/bad_input`
```
{$pretty_name} [Migration Error: Bad input at](@error) [rx.playerdb:temp admin.migrate](@emphasis) [is empty](@error)
```

`@allay_message rx.playerdb:admin/migration/acc_not_found`
```
{$pretty_name} [Migration Error: Input UUID account not found](@error)
```

`@allay_message rx.playerdb:admin/migration/success`
```
@temp = (insertion="/scoreboard players reset ")

#ALLAYDEFS

{$pretty_name} [Migration Success:](@success) {nbt="admin.migrate.old_name", storage="rx.playerdb:temp"}(@emphasis)['s data was migrated to](@success) {@s}(@emphasis)

[→ Run ](gray) [/scoreboard players reset {nbt="admin.migrate.old_name", storage="rx.playerdb:temp"}](@emphasis, @temp) [to complete the migration process!](gray)
```

`@allay_message rx.playerdb:admin/migration/success_to_migrated`
```
{$pretty_name} [Migration Success:](@success) {nbt="admin.migrate.old_name", storage="rx.playerdb:temp"}(@emphasis)['s data was successfully migrated to you!](@success)
```

`@allay_message rx.playerdb:admin/reset`
```
{$pretty_name} [Reset Success: PlayerDB successfully reset](@success)
```

</details>

# Misc Messages

<details>

`@allay_message rx.playerdb:api/name_change`
```
{$pretty_name} {nbt="old_name", storage="rx.playerdb:io"}(@emphasis) [has changed their name to](@success) {@s}(@emphasis)
```

`@allay_message rx.playerdb:upgrade/v1tov2`
```
{$pretty_name} [Upgrade Success: PlayerDB v1 upgraded to v2](@success)
```

`@allay_message rx.playerdb:upgrade/v1tov2/player`
```
{$pretty_name} [Upgrade Success: Your data has been safely transfered :)](@success)
```

</details>