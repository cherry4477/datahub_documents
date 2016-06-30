---
title: 'pull 命令'
---

pull命令用来下载您已订阅的DataItem下的Tag到你所指定的Datapool。

** 拉取某个 DataItem 的 Tag **

	datahub pull $REPOSITORY/$DATAITEM:$TAG $DATAPOOL[://$LOCATION] [--destname，-d]
其中：参数[--destname, -d ]作用是重命名需要下载的Tag，可以缺省。缺省状态下默认名称为pull的Tag名字。

例子：

	$ datahub pull cmcc/beijing:chaoyang dp1://cmccbj
      DataHub : OK.

** 针对 Repository／DataItem 的自动（取消自动）下载 **

	datahub pull $REPO/$DATAITEM:$TAG $DATAPOOL[://$LOCATION] [--automatic，-a]
        
	datahub pull $REPO/$DATAITEM:$TAG $DATAPOOL[://$LOCATION] [--cancel，-c]
        
其中：参数[--automatic，-a] 表示自动下载已订阅的DataItem新增的Tag；参数[--cancel，-c]表示取消自动下载Tag。

例子:

Repository／DataItem 自动下载：

	$ datahub pull cmcc／beijing dp1 –-automatic
 	  DataHub : cmcc／beijing will be pulled automatically.
      

例子:

Repository／DataItem 取消自动下载：

	$ datahub pull repo/DataItem dp1 --cancel
      DataHub : Cancel the automatical pulling of repo/DataItem successfully.


