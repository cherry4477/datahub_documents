---
title: 'subs 命令'
---

** 列出所有已订阅项 **

	datahub subs 

例子：

	$ datahub subs
	  REPOSITORY/DATAITEM     TYPE    STATUS
	  cmcc/beijing            file    online
	  repo1/testing           hdfs    online
    
** 列出用户在某个 Repository 下已订阅的 DataItem **

	datahub subs $REPOSITORY

例子：

	$ datahub subs cmcc
      REPOSITORY/DATAITEM     TYPE    STATUS
	  cmcc/Beijing            file    online
	  cmcc/Tianjin            file    online
	  cmcc/Shanghai           file    online

** 列出已订阅 DataItem 详情 **

	datahub subs $REPOSITORY/$DATAITEM
  
例子：

   	$ datahub subs cmcc/beijing
      REPOSITORY/DATAITEM:TAG      UPDATETIME              COMMENT      STATUS
      cmcc/beijing:chaoyang    	   15:34 Oct 12 2015       600M         NORMAL
      cmcc/beijing:daxing      	   16:40 Oct 13 2015       435M         NORMAL
      cmcc/beijing:shunyi      	   16:40 Oct 14 2015       324M         NORMAL
	  cmcc/beijing:haidian     	   16:40 Oct 15 2015       988M         NORMAL