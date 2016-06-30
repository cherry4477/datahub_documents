---
title: 'job 命令'
---

** job 查看所有任务列表，包括数据下载和发送的任务 **

	datahub job
    
例子：

	$ datahub job
      JOBID       STATUS       DOWN     TOTAL      PERCENT      TAG
      ----------------------------------------------------------------------------------------
      72cbddes   downloaded    893      893        100.0%       Base_station/Location:location


** job 查看某个任务 id 对应的信息 **
	
    datahub job &JOBID

例子：

    $ datahub job 72cbddes
	  JOBID       STATUS       DOWN     TOTAL     PERCENT     TAG
	  ---------------------------------------------------------------------------------------
	  72cbddes    downloaded   893      893       100.0%       Base_station/Location:location


** job rm 删除某个 job **
	
    datahub job rm &JOBID
    