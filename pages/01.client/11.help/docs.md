---
title: 'help 命令'
---

help 提供 DataHub 所有命令的帮助信息。


	datahub help [$CMD] [$SUBCMD]

例子:

    $ datahub help dp
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
    
