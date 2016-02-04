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
| login       | 登录到 dataos.io  | 
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

	datahub dp $DPNAMEt

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

	datahub dp create $DPNAME [file://][ABSOLUTE PATH]

输出

	%msg

例子

    $ datahub dp create testdp file:///var/lib/datahub/testdp
    dp create success. name:testdp type:file path:/var/lib/datahub/testdp
    $
    
#### 1.4 删除数据池
删除数据池不会删除目标数据池已保存的数据。该 dp 有发布的数据项时，不能被删除。删除是在 sqlite 中标记状态，不真实删除。

	datahub dp rm $DPNAME

输出

	%msg

例子

    $ datahub dp rm testdp
    Datapool testdp with type:file removed successfully!
    $
    
### 2 login 命令

login 命令支持被动调用，用于 DataHub client 与 DataHub server 交互时作认证。并将认证信息保存到环境变量，免去后续指令重复输入认证信息。

登陆到 dataos.io

	datahub login [--user=user]

输出

	%msg
    
例子

    $ datahub login
    login: datahub
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
    
#### 3.2 列出已订阅 item 详情

	datahub subs $REPO/$ITEM

输出

    %REPO/%ITEM     %TYPE
    DESCRIPTION:
    %DESCRIPTION
    METADATA:
    %METADATA
    {%ITEM:%TAGNAME %UPDATE_TIME    %INFO}
    
例子

    $ datahub subs cmcc/beijing
    cmcc/beijing    regular file
    DESCRIPTION:
    移动数据北京地区
    METADATA:
    BLABLABLA
    beijing:chaoyang    15:34 Oct 12 2015       600M
    beijing:daxing  16:40 Oct 13 2015       435M
    beijing:shunyi  16:40 Oct 14 2015       324M
    beijing:haidian 16:40 Oct 15 2015       988M
    $

### 4 pull 命令
拉取某个 item 的 tag。

pull 一个 tag ，需指定`$DATAPOOL`, 可再指定`$DATAPOOL`下的子目录`$LOCATION`，默认下载到`$DATAPOOL://$REPO_$ITEM`。 可选参数`[--destname, -d]`命名下载的 tag 。

	datahub pull $REPO/$ITEM:$TAG $DATAPOOL[://$LOCATION] [--destname，-d]

输出

	%msg

例子

	$ datahub pull cmcc/beijing:chaoyang dp1://cmccbj
    OK.
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
    Pub success,  OK

#### 5.2 发布一个 tag

	datahub pub $REPO/$ITEM:$Tag $TAGDETAIL --comment=" "

输出

	Pub success, OK

例子

    $ datahub pub music_1/migu:migu_user_info migu_user_info.txt
    Pub success, OK
    $

### 6 repo 命令

查询自己创建的和具有写权限的所有 repository 。

	datahub repo 

输出

    REPOSITORY
    --------------------
    Location_information                    
    Internet_stats  
    Base_station_location
    
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
