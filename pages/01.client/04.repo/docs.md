---
title: 'repo 命令'
---

** 查询自己创建的和具有写权限的所有 Repository **

	datahub repo  

例子：

    $ datahub repo
      REPOSITORY
      --------------------
      Location_information                    
      Internet_stats  
      Base_station_location

** 查询 Repository 的详情 **

	datahub repo $REPOSITORY

例子：

    $ datahub repo Internet_stats

      REPOSITORY/DATAITEM
      --------------------------------
      Internet_stats/Music
      Internet_stats/Books
      Internet_stats/Cars
      Internet_stats/Ecommerce_goods
	  Internet_stats/Film_and_television

** 查询 DataItem 的详情 **

	datahub repo  $REPOSITORY/$DATAITEM

例子：

    $ datahub repo Internet_stats/Music
	  REPOSITORY/DATAITEM:TAG 						  UPDATETIME  				      COMMENT
      -------------------------------------------------------------------------------------
      Internet_stats/Music:music_baidumusic_6008      2016-03-04 09:15:18|6天前 	     百度音乐
      Internet_stats/Music:music_qqmusic_6001         2016-02-03 09:23:30|1个月前  	QQ音乐
	  Internet_stats/Music:music_kuwomusic_6005       2016-01-06 09:35:44|2个月前  	酷我音乐


** 删除自己创建的 DataItem **

	datahub repo rm $REPOSITORY/$DATAITEM

例子：
    
    $ datahub repo rm myrepo/myitem
      Datahub : After you delete the DataItem, data could not be recovery, and all tags would be deleted either.
      Are you sure to delete the current DataItem?[Y or N]:Y
	  DataHub : OK

说明：当此DataItem下有正在生效的订购计划时，会提示资费回退规则。

** 删除自己创建的 Tag **

	datahub repo rm $REPOSITORY/$DATAITEM:$TAG

例子：

    $ datahub repo rm FavouriteMusic/MusicItem:bingyu
	  DataHub : After you delete the Tag, data could not be recovery.
	  Are you sure to delete the current Tag?[Y or N]:y
	  DataHub : OK
     