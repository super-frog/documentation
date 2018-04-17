### Handler

上一节讲到 **路由** 的声明里提及到的 **handler名字** ,

对应的就是 `/handlers` 目录下的文件名。

`frog`对 **handler** 的要求，只需要导出一个 `async function`即可。

**handler** 对上层通信协议是**无感知**的，
 
因而它不会像一些传统的控制器那样需要`req` `res`参数。

> 协议无感知。这样设计的好处是，如果将来需要在底层通信协议上支持更多的可能性。

> 也可以做到不用更改业务层代码。

至于开发者关心的，  **handler** 如何得到请求参数，如何响应内容,

会在接下来的章节里详细讲。

这一节，只需要记住:

```javascript
router.post('', 'create_event')
```
对应的业务逻辑是

```
/handlers/create_event.js
```

接下来，我们先看一个完整的例子，后面的几个章节都会从这个例子将开去。

```javascript
'use strict';
const EventModel = require('../definitions/models/Event.gen');

const Event = {
  //名字 string:1,64 in:body require
  name: 'unamed',
  //日期 string:10,10 in:body require
  date: '2018-01-01',
  //类型 enum:小活动,专场活动,大型活动 in:body
  type: 1,
  //描述 string:0,255 in:body
  desc: '',
};

module.exports = async (Event) => {
  let model = EventModel.create(Event);
  let saved = await model.save(true);
  if (saved === true) {
    return model;
  } 
  return error.INTERNAL_ERROR.withMessage('写入数据错误');
};
```
