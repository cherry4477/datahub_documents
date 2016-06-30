---
title: 'datapool 命令'
---

** 列出所有命令池 **

列出所有数据池（datapool）。

	datahub dp
    
例子：

    $ datahub dp
      DATAPOOL            TYPE
      ------------------------
      dp1                 file 
      dp2                 db2
      dphdfs              hdfs
      dps3                s3
	
    
** 列出 Datapool 详情 **

指定一个datapool，列出此datapool详情。

	datahub dp $DPNAME

例子：

    $ datahub dp dp1
      DATAPOOL:dp1                    file                      /var/lib/datahub/dp1
      repo1/item1:tag1                2015-10-23 03:57:42       pub		repo1_item1       tag1.txt    		 Size:232.00KB
      repo1/item1:tag2                2015-10-23 03:59:49       pub		repo1_item1	      tag2
      repo1/item2:jinrong-40          2015-10-23 04:01:22       pull	item2location	  jinrong_40.txt	 金融信息
      cmcc/beijing:jiangsu            2015-11-19 10:57:21       pull	cmcc_beijing	  jiangsu.txt        位置区编码
	
    
说明：cmcc_beijing为DataItem beijing在Datapool dp1中的位置， jiangsu.txt为Tag存储到dp1中的文件名，“位置区编码”为详细信息。
    
** 创建数据池 **

新建一个datapool。

	datahub dp create $DPNAME [[file://][ABSOLUTE PATH]] | [[s3://][BUCKET]] | [[hdfs://][USERNAME:PASSWORD@HOST:PORT]]

其中：[file://][s3://][hdfs://]为datapool类型；[absolute path]为datapool保存路径（且保存类型必须设置）

例子1：

    $ datahub dp create testdp file:///var/lib/datahub/testdp
	  DataHub : Datapool has been created successfully. Name:testdp Type:file Path:/var/lib/datahub/testdp.
  
    
例子2：

    $ datahub dp create s3dp s3://mybucket
	  DataHub : s3dp already exists, please change another name.

说明：mybucket是s3上已存在的bucket。另外，需要在启动daemon的系统中设置环境变量：AWS_SECRET_ACCESS_KEY， AWS_ACCESS_KEY_ID， AWS_REGION。
    
例子3：

    $ datahub dp create hdfsdp hdfs://user123:admin123@x.x.x.x:9000

说明：“hdfs://”后需要接hdfs的连接串。
    
** 删除数据池 **

删除数据池不会删除目标数据池已保存的数据。该datapool有发布的数据项时，不能被删除。删除是在sqlite中标记状态，不真实删除。若datapool中存在已经发布的数据，则不能删除datapool。需要删除datapool下发布的数据后方可删除。

	datahub dp rm $DPNAME

例子：

    $ datahub dp rm testdp
	  DataHub : Datapool testdp removed successfully!
