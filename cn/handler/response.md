### 响应

`frog` 并不像传统的控制器类框架那样，要业务逻辑调用 `res.*`之类的方法来返回结果。

`frog`要求 **handler** 导出一个 `async function`, 如：

```
module.exports = async (Event) => {
  let model = EventModel.create(Event);
  let saved = await model.save(true);
  if (saved === true) {
    return model;
  } 
  return error.INTERNAL_ERROR.withMessage('写入数据错误');
};
```

业务逻辑并不感知到`response`， 

只需要像一个普通函数一样，**return**它的结果就行，

`frog`底层会自动处理这个返回值。

> 关于 frog 的 error 会在后面的章节讲解。


这样设计的好处是，

如果我需要测试我的 **handler**, 我只需要照着参数(例子里的Event)的结构定义去mock，

然后检查这个`async function`的值，就像测试一个普通的**function**一样。

而不需要引入整个 **http** 实现。