---
title: 'DataHub 客户端命令介绍'
taxonomy:
    category:
        - docs
---

DataHub client 是 DataHub 的命令行客户端，用来执行 DataHub 相关命令。

| 命令	    | 用途              |
| :---------- | :----------       |
| dp          | Datapool 管理      |
| repo        | Repository 管理    |
| subs        | Subscrption 管理   |
| ep          | Entrypoint管理	 |
| login       | 登录到 dataos.io  | 
| logout      | 退出登录          |
| pull        | 下载数据           |
| pub         | 发布数据           |
| job         | 显示任务列表       |
| help        | 帮助命令           |  

>>>>>备注：

* 命令在没有错误发生时，会记录到日志中（`/var/log/datahub.log`）。错误信息会打印到终端。
* 日志级别分为 [TRACE] [DEBUG] [INFO] [WARNNING] [ERROR] [FATAL]。
* 参数支持全名和简称两种形式，例如`--type`等同于`-t`。详情见命令帮助。
* 参数赋值支持空格和等号两种形式，例如`--type=file`等同于`--type file`。


### 1 datapool 相关命令
如果需要 pull 数据，则必须创建相应的 datapool 。

#### 1.1 列出所有命令池

	datahub dp
    
输出
	
    {%DPNAME    %DPTYPE}

例子

    $ datahub dp
    dp1     regular file 
    dp2     db2
    dphere  hdfs
    dpthere api
	$
    
#### 1.2 列出 datapool 详情

	datahub dp $DPNAME

输出

    %DPNAME %DPTYPE %DPCONN
    {%REPO/%ITEM:%TAG	%LOCAL_TIME	%T}

例子

    $ datahub dp dp1
    dp1 regular file    /var/lib/datahub/dp1

    repo1/item1:tag1        12:34 Oct 11 2015       pub
    repo1/item1:tag2        15:00 Nov 2  2015       pub
    repo1/item2:latest  10:00 Nov 1  2015       pull
    cmcc/beijing:latest 10:00 Nov 1  2015       pull
    $ 
    
#### 1.3 创建数据池
目前只支持本地目录形式的数据池创建。

	datahub dp create $DPNAME [[file://][ABSOLUTE PATH]] [[s3://][BUCKET]]

输出

	%msg

例子1

    $ datahub dp create testdp file:///var/lib/datahub/testdp
    DataHub : dp create success. name:testdp type:file path:/var/lib/datahub/testdp
    $
    
例子 2

	$ datahub dp create s3dp s3://mybucket
	DataHub : dp create success. name:s3dp type:s3 path:mybucket
	$

    
#### 1.4 删除数据池
删除数据池不会删除目标数据池已保存的数据。该 dp 有发布的数据项时，不能被删除。删除是在 sqlite 中标记状态，不真实删除。

	datahub dp rm $DPNAME

输出

	%msg

例子

    $ datahub dp rm testdp
    DataHub : Datapool testdp with type:file removed successfully!
    $
    
### 2 login 命令

login 命令支持被动调用，用于 DataHub client 与 DataHub server 交互时作认证。并将认证信息保存到环境变量，免去后续指令重复输入认证信息。

登陆到 dataos.io

	datahub login [--user=user]

输出

	%msg
    
例子

    $ datahub login
    login as: datahub
    password: *******
    [INFO]Authorization failed.
    $

### 3 subs 相关命令
#### 3.1 列出所有已订阅项

	datahub subs 

输出

	{%REPO/%ITEM    %TYPE}

例子

	$ datahub subs
    cmcc/beijing        regular file
    repo1/testing       api
    $
  
#### 3.2 列出用户在某个repository下已订阅的item

	datahub subs $REPO

	输出

	%REPO/%ITEM     %TYPE
	{%ITEM:%TAGNAME %UPDATE_TIME    %INFO}

	例子

		$ datahub subs cmcc
			cmcc/beijing    regular file
		$ datahub subs cmcc
			cmcc/Beijing     file
			cmcc/Tianjin     file
			cmcc/Shanghai    file
		$

    
#### 3.3 列出已订阅 item 详情

	datahub subs $REPO/$ITEM

输出

    %REPO/%ITEM     %TYPE
    {%ITEM:%TAGNAME %UPDATE_TIME    %INFO}
    
例子

    $ datahub subs cmcc/beijing
    beijing:chaoyang    15:34 Oct 12 2015       600M
    beijing:daxing  16:40 Oct 13 2015       435M
    beijing:shunyi  16:40 Oct 14 2015       324M
    beijing:haidian 16:40 Oct 15 2015       988M
    $

### 4 pull 命令
拉取某个 item 的 tag。

pull 一个 tag ，需指定`$DATAPOOL`, 可再指定`$DATAPOOL`下的子目录`$LOCATION`，默认下载到`$DATAPOOL://$REPO_$ITEM`。 可选参数`[--destname, -d]`命名下载的 tag [--automatic, -a]自动下载已订阅的Item新增的tag [--cancel, -c]取消自动下载tag 。

	datahub pull $REPO/$ITEM:$TAG $DATAPOOL[://$LOCATION] [--destname，-d]

输出

	%msg

例子

	$ datahub pull cmcc/beijing:chaoyang dp1://cmccbj
    	DataHub : OK.
        $
    
### 5 pub 相关命令

pub 分为发布一个 DataItem 和发布一个 Tag 。

发布 DataItem 必须指定 DATAPOOL 和 DATAPOOL 下的子路径 LOCATION , 可选参数`--accesstype`, `-t=` 指定DataItem属性：public, private, 默认private 。

发布 Tag 必须指定 TAGDETAIL , 用来指定 Tag 对应文件名，该文件必须存在于`$DATAPOOL://$LOCATION`内。

可选参数`--comment`, `-m=` ,描述 DataItem 或者 Tag 。

#### 5.1 发布一个 item

	datahub pub $REPOSITORY/$DATAITEM $DATAPOOL://$LOCATION --accesstype=public [private]  [--comment, -m]

输出

	Pub success,  OK

例子

    $./datahub pub music_1/migu mydp://dirmigu --accesstype=public --comment="migu music desc"
    DataHub : Pub success,  OK

#### 5.2 发布一个 tag

	datahub pub $REPO/$ITEM:$Tag $TAGDETAIL --comment=" "

输出

	Pub success, OK

例子

    $ datahub pub music_1/migu:migu_user_info migu_user_info.txt
    DataHub : Pub success, OK
    $

### 6 repo 命令

#### 6.1 查询自己创建的和具有写权限的所有 repository

	datahub repo 

输出

    REPOSITORY
    --------------------
    Location_information                    
    Internet_stats  
    Base_station_location

#### 6.2 查询repository的详情

	datahub repo Internet_stats

输出

    REPOSITORY/DATAITEM
    --------------------------------
    Internet_stats/Music
    Internet_stats/Books
    Internet_stats/Cars
    Internet_stats/Ecommerce_goods
	Internet_stats/Film_and_television

#### 6.3 查询dataitem的详情

	datahub repo rm Internet_stats/Music

输出

	REPOSITORY/ITEM:TAG UPDATETIME  COMMENT
    ---------------------------------------------------
    Internet_stats/Music:music_baidumusic_6008  2016-03-04 09:15:18|6天前 百度音乐
    Internet_stats/Music:music_qqmusic_6001     2016-02-03 09:23:30|1个月前  QQ音乐
	Internet_stats/Music:music_kuwomusic_6005   2016-01-06 09:35:44|2个月前  酷我音乐


#### 6.4 删除自己创建的dataitem

	datahub repo rm myrepo/myitem

输出

    Datahub : After you delete the DataItem, data could not be recovery, and all tags would be deleted either.
    Are you sure to delete the current DataItem?[Y or N]:Y
	DataHub : OK

说明：当此dataitem下有正在生效的订购计划时，会提示资费回退规则。

#### 6.5 删除自己创建的tag

	datahub repo rm FavouriteMusic/MusicItem:bingyu

输出

	DataHub : After you delete the Tag, data could not be recovery.
	Are you sure to delete the current Tag?[Y or N]:y
	DataHub : OK
    
### 7 job 命令
#### 7.1 job 查看所有任务列表，包括数据下载和发送的任务

	datahub job

#### 7.2 job 查看某个任务 id 对应的信息
	
    datahub job &JOBID

#### 7.3 job rm 删除某个 job
	
    datahub job rm &JOBID

### 8 help命令

help 提供 DataHub 所有命令的帮助信息。

列出帮助

	datahub help [$CMD] [$SUBCMD]

输出

    Usage of %CMD %SUBCMD
    {  %OPTION=%DEFAULT_VALUE     %OPTION_DESCRIPTION}

例子

    $datahub help dp
    Usage: 
      datahub dp [DATAPOOL]
    List all the datapools or one datapool

    Usage of datahub dp create:
      datahub dp create DATAPOOL [file://][ABSOLUTE PATH]
      e.g. datahub dp create dptest file:///home/user/test
           datahub dp create dptest /home/user/test
    Create a datapool

    Usage of datahub dp rm:
      datahub dp rm DATAPOOL
    Remove a datapool
    $

### 9 logout 命令

logout 命令支持被动调用，用于 DataHub client 与 DataHub server 交互时作认证。并将认证信息保存到环境变量，免去后续指令重复输入认证信息。

退出登录

	datahub logout [--user=user]

输出

	%msg
    
例子

    $ datahub logout
    DataHub : Logout success.
    $
    
### 10 ep 命令

  若需要向DataHub发布数据，需提供ENTRYPOINT。

  		 datahub ep [http://HOST:PORT]
   
   输出:
   
   		%msg
        
   例子：
   
		$datahub ep http://10.1.235.98:8080
        entrypoint: http://10.1.235.98:8080
        DataHub : OK. your entrypoint is: http://10.1.235.98:8080
        $
