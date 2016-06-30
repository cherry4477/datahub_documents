---
title: 'login 命令'
---

login 命令支持被动调用，用于 DataHub client 与 DataHub server 交互时作认证。并将认证信息保存到环境变量，免去后续指令重复输入认证信息。

	datahub login [--user=user]
   
例子:

    $ datahub login
	  login as: datahub
	  password: *******
	  DataHub : Login success.

    