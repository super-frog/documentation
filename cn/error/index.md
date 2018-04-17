### 优雅的定义错误

开发的过程中我们有时候需要具体地定义每一种错误。

比如我们要根据ID查找一个用户，可能会出现：

- 传入的ID范围不对
- 用户不存在
- 你没有权限查看这个用户

等等。

> 过去，我们要亲自定义每个错误的 **错误原语**、**错误编码**

> 尤其是 **错误编码** 时间长了，服务多了，需要维护一个统一的编码变得十分困难。

> 而在`frog`里，我们跳出了这个困境。

我们看一个具体的例子

```javascript
let Error = {
  //找不到啦
  NOT_FOUND: 404,
  //用户找不到啦
  USER_NOT_FOUND: 404,
  //不准你看
  UNAUTHORIZED: 403,
  //{错误原语}
  {名字}: {错误组}
}
```
`frog`只需要你写一个`Error`对象，定义好每一种错误的

- 错误原语

  错误提示语，就是错误的 `message`

- 名字

  编码时用到的名字

- 错误组

  `frog`采取 **http status code** 风格来定义错误的分组

同样是借助**AST**技术，`frog`会为你自动编排错误码，生成的代码如下

```javascript
module.exports = [
  {
    name: 'NOT_FOUND',
    httpStatus: 404,
    code: (process.env.APPID || 1001)*1e6+404001,
    message: '找不到啦',
  },
  {
    name: 'USER_NOT_FOUND',
    httpStatus: 401,
    code: (process.env.APPID || 1001)*1e6+404002,
    message: '用户找不到啦',
  },
  {
    name: 'UNAUTHORIZED',
    httpStatus: 403,
    code: (process.env.APPID || 1001)*1e6+403001,
    message: '不准你看',
  }
];
```

`frog`的错误编码格式为 `{4位服务编码} {3位http_status} {3位错误序号}`

观察上面代码发现，同为 **404** 组的两个错误，会自动分配不重复的 **序号**

> APPID是服务编码，使用环境变量注入，这在docker体系里是非常自然的做法。

而我们在 **handler** 里需要返回错误时，

只需要 

```javascript
return error.USER_NOT_FOUND;
```

这样就可以了。

因为`frog`底层会将上面的编排的结果(一个数组)，

自动实例化一组**error**对象，并放到**全局变量里**，方便食用。

> 这个地方的设计有点不舒服，不希望用全局变量，代码提示无法支持。

> 但是这样可以比较方便使用，优化方案有待发现。