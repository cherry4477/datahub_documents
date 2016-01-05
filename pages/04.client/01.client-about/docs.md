---
title: 'DataHub 客户端程序简介'
taxonomy:
    category:
        - docs
---

datahub程序具有两个功能：
1. client
2. daemon

datahub client是用于在命令行输入指令的客户端，其功能只是向daemon发送指令，并展示返回信息。

datahub daemon是常驻后台的进程，负责接收client的指令，并执行，即datahub的实际功能都是通过daemon实现的。

二者启动命令相同，通过启动参数区分，启动命令都是datahub， 带参数—daemon，表示启动datahub daemon，不带参数--daemon表示启动datahub client。
