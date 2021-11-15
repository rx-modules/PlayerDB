# Changelog

<!--next-version-placeholder-->

## v2.0.0 (2021-11-11)
### Breaking Changes
* Must use Minecraft version 1.18+

* Many namespaces have been updated
	* **Storage**:
		* `rx:global playerdb` -> `rx.playerdb:main`
		* `rx:io playerdb` -> `rx.playerdb:io`
		* `rx:temp playerdb` -> `rx.playerdb:temp`
		* **Example**: `rx.playerdb:io player.data`
		
	* **Scoreboards**:
		* `rx.pdb.hasEntry` -> `rx.pdb.has_entry`
		* `rx.pdb.LT` -> `rx.pdb.list_trigger`
		* (..etc)
		
	* **API**, note the `#` indicating function tags:
		* `rx.playerdb:api/get_self` -> `#rx.playerdb:api/v2/get/self`
		
		* `rx.playerdb:api/save` -> `#rx.playerdb:api/v2/save`
		
		* `#rx.playerdb:api/on_name_change` -> `#rx.playerdb:api/v2/on_name_change`
		
		* **Example**:
			```mcfunction
			function #rx.playerdb:api/v2/get/self
			data modify storage rx.playerdb:io player.data.a set value 3b
			function #rx.playerdb:api/v2/save/self
			```

> Please pay close attention to the new API setup. This is vital to allow for packs to be bundlable so I took advantage of the 1.18 removed limits to rename some badly named objectives.

### Features
* PlayerDB can now be bundled! Checkout the usage section on the wiki to learn more!
	* Essentially, this allows you to ship your datapack with PlayerDB included allowing your users to only need to download your pack!

### Fixes
* `#api/v2/on_name_change` can never infinite loop.
	* If you attempt to `#api/v2/get/self`, it will fail and output an error message which you can read via the `rx.admin` tag.
* Nearly every error message has been updated, esp across the `admin` suite
* Many of the `admin` things have been cleaned up (looking at you `migrate_acc`)
	* Note, `admin` tools are designed to be ran in chat and not via datapack commands.
	* Running them via helper functions is fine, aslong as you keep track of newer admin updates since they are **not** versioned!
* Login detection now works properly on server crashes. Also triggers on `/reload`
	* This should help catch some name changes ensuring this feature works more accurately!
