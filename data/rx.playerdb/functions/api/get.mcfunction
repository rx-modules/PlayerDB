# By: rx97
# 14 Aug 2020
# 
#> Get Data: Output in rx:io out.player

execute if score $in.uid rx.io < $uid.next rx.uid run function rx.playerdb:impl/select
execute if score $in.uid rx.io < $uid.next rx.uid run function rx.playerdb:impl/get
