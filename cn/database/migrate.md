### 同步 / 迁移

数据表结构的同步与迁移，在多环境以及协同开发时，是非常重要的功能。

`frog`在每次 **build** 程序时，都会根据当前代码里定义的模型生成数据表结构，

再 **diff** 同步到数据库。

通过代码来管理数据表结构，你不需要再担心不同的环境(**开发与测试**)，不同的开发人员(**小明与小张**)之间的数据库结构不一样。


> **migrate** 会在每次 **build** 时自动进行，后期会加入是否自动**migrate**的开关的功能。
