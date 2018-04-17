### 编写一个模型 

我们直接看一个例子：


```javascript
const { Field, Table, Migrate, Presets } = require('xiaolan-db');

module.exports = new Table('submit', {
  ...Presets.AI,
  eventID: Field.name('event_id').bigint(true).index().uniq('event_user').comment('活动ID'),
  userID: Field.name('user_id').bigint(true).index().uniq('event_user').comment('用户ID'),
  status: Field.name('status').tinyint(true).default(0).index().comment('0初始化 1签到后 2开发签到'),
  submitTime: Field.name('submit_time').bigint(true).comment('报名时间'),
  ...Presets.opTime,
});
```

```sql
CREATE TABLE `submit` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary id',
  `event_id` bigint(20) unsigned NOT NULL COMMENT '活动ID',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0初始化 1签到后',
  `create_time` bigint(20) unsigned NOT NULL,
  `update_time` bigint(20) unsigned NOT NULL,
  `submit_time` bigint(20) unsigned NOT NULL COMMENT '报名时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_user` (`event_id`,`user_id`),
  KEY `i_event_id` (`event_id`),
  KEY `i_user_id` (`user_id`),
  KEY `i_status` (`status`),
  KEY `i_create_time` (`create_time`),
  KEY `i_update_time` (`update_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1503 DEFAULT CHARSET=utf8;
```

#### 我们简单说一些会用到的API

- Field

  name(string) 字段名( **name必须是第一个被调用的！** )

      Field.name('abc')

  tinyint(unsigned = bool), 整数类型。
  同理 smallint, int, mediumint, bigint 

      Field.name('abc').smallint(true) 
  
  float(长度, 小数, unsigned) 浮点数类型

      Field.name('rate').float(6, 3, true)
  
  char(长度) varchar(长度)

      Field.name('nickname').char(64)

  text() **text不用定义长度**

      Field.name('content').text()

  allowNull() 设置字段允许空(默认NOT NULL)

      Field.name('ext').varchar(64).allowNull()

  default(v) 默认值

      Field.name('nickname').char(64).default('foo')

  AI() 设置自增

      Field.name('id').int(true).AI()

  primary() 设为主键

      Field.name('id').int(true).AI().primary()
  
  comment() 字段注释

      Field.name('nickname').char(64).comment('昵称')
  
  index(string)、uniq(string) 定义索引

      Field.name('tel').char(11).uniq() 
      //索引名默认为字段名，如果自定义索引名，相同索引名的字段会成为联合索引
      Field.name('realname').char(64).uniq('realname_gender'),
      Field.name('gender').tinyint(true).uniq('realname_gender'),

- Table
  
  Table的构造函数要求传入两个参数

  - 表名字
  - 值为`Field`对象的键值对

- Presets
  
  定义Table的过程中，可以使用一些预设的字段（比如上面的例子）,目前内置了两个：

  - presets.AI 

    提供一个自增主键ID的标准定义

  - presets.opTime

    提供一对时间记录字段，create_time、 update_time, 
  
  以上预设内容建议直接使用。
  