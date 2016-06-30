---
title: 'DataHub 应用场景举例'
---

** 发布数据 **

- 发布数据是数据提供方行为。

在 DataHub 产品中，数据组织划分为 Repository 、DataItem 、Tag ，其中 Repository 是数据仓库， DataItem 是一个数据项，包含一个主题的数据， Tag 是一个具体的数据记录。

提供方发布数据前要在本地基于已有数据建立一个 Datapool，发布这个 Datapool 里面的数据。

假设在`/home/myusr/data/topub`目录下存在若干文件，现在想把这些文件发布为一些 tags ，等待需求方来下载。
操作过程如下：

	1) datahub dp create mydatapool file:///home/myusr/data

以上命令创建了一个Datapool，类型是file，路径是`/home/myusr/data`。

	2) datahub pub myrepo/myitem mydatapool://topub --accesstype=public --comment="my test item "

发布一个名称为 myitem 的 DataItem ，所属 Repository 是 myrepo ，对应 mydatapool 的子目录 topub ，即待发布数据存在于`/home/myusr/data/topub`中。

>>>>注意：在发布 DataItem 之前，可以在其对应的目录里创建、编译三个文件：sample.md, meta.md, price.cfg。

这三个文件的作用分别是：
* sample.md 用于保存 markdown 格式的样例数据，如果没有此文件，程序会读取此目录下的一个 tag 文件的前十行，作为样例数据，发布到 dataitem 的详情里。
* meta.md 用于保存 markdown 格式的元数据。
* price.cfg 用于保存 json 格式的资费计划，用来明确此 DataItem 的资费。格式如下：

```markdown
{
"price":[
                {
                    "times":10,
                    "money": 5,
                    "expire":30
                },
                {
                    "times": 100,
                    "money": 45,
                    "expire":30
                },
                {
                    "times":500,
                    "money": 400,
                    "expire":30
                }
        ]
}
```

	3) datahub pub myrepo/myitem:mytag test.txt

发布一名称为 mytag 的 Tag ，所属 DataItem 是 myitem ，对应数据文件是 `/home/myusr/data/topub/test.txt`。

** 下载数据 **

- 下载数据是数据需求方的行为。

需求方用户登录 http://hub.dataos.io ，查看、搜索 Repository 、DataItem ，然后订购自己所需的 DataItem 。订购成功后，在 Tag 详情页面，点击复制，复制 Tag 全名，即可在客户端下载此 DataItem 下的 Tag 所对应的数据。

DataHub Client 操作如下：

	1）datahub dp create mydp file:///home/usr/data/itempull 
	
以上命令创建了一个名为 mydp 的 Datapool ，类型是 file ，路径是`/home/myusr/data/itempull`, 用于存储即将下载 的数据。
	
    2）datahub pull repotest/itemtest:tagtest mydp://mydir1 –d tagdestname.txt

下载一个 Tag 对应的数据到 mydp 中，子路径是 mydir1。