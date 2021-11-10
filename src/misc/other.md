<!-- Other Resources --> 

```yaml
// @loot_table rx:player_head
---
type: minecraft:entity
pools:
- rolls: 1
  entries:
  - type: minecraft:item
    functions:
    - function: minecraft:fill_player_head
      entity: this
    - function: minecraft:set_name
      entity: this
      name:
        selector: "@s"
        color: blue
        italic: false
    - function: minecraft:set_nbt
      tag: "{rx.player_head:1b}"
    name: minecraft:player_head
```

```yaml
// @loot_table minecraft:blocks/yellow_shulker_box
---
type: 'block'
pools:
  - rolls: 1
    entries:
      - type: 'minecraft:alternatives'
        children:
          - type: 'minecraft:dynamic'
            name: 'minecraft:contents'
            conditions:
              - condition: 'minecraft:match_tool'
                predicate:
                  items:
                    - 'minecraft:air'
                  nbt: '{drop_contents:1b}'
          - type: 'minecraft:item'
            name: 'minecraft:yellow_shulker_box'
            functions:
              - function: 'minecraft:copy_name'
                source: block_entity
              - function: 'minecraft:copy_nbt'
                source: block_entity
                ops:
                  - source: Lock
                    target: BlockEntityTag.Lock
                    op: replace
                  - source: LootTable
                    target: BlockEntityTag.LootTable
                    op: replace
                  - source: LootTableSeed
                    target: BlockEntityTag.LootTableSeed
                    op: replace
              - function: 'minecraft:set_contents'
                entries:
                  - type: 'minecraft:dynamic'
                    name: 'minecraft:contents'
```