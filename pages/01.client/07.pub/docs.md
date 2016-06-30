---
title: 'pub 命令'
---

 pub 分为发布一个 DataItem 和发布一个 Tag 。

 发布 DataItem 必须指定 `$DATAPOOL` 和 `$DATAPOOL` 下的子路径 `$LOCATION`。

 发布 Tag 必须指定 TAGDETAIL , 用来指定 Tag 对应文件名，该文件必须存在于`$DATAPOOL://$LOCATION`内。

 可选参数`--comment`, `-m=` ,描述 DataItem 或者 Tag 。

 可选参数`--accesstype`, `-t=` 指定 DataItem 属性：public, private, 默认private 。

** 发布一个 DataItem **

	datahub pub $REPOSITORY/$DATAITEM $DATAPOOL://$LOCATION --accesstype=public [private]  [--comment, -m]

例子：

    $ datahub pub music_1/migu mydp://dirmigu --accesstype=public --comment="migu music desc"
      DataHub : Successfully published

** 发布一个 Tag **

	datahub pub $REPOSITORY/$DATAITEM:$Tag $TAGDETAIL --comment=" "

例子：

    $ datahub pub music_1/migu:migu_user_info migu_user_info.txt
      DataHub : Successfully published
