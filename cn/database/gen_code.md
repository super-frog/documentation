### 代码生成

`frog`会在每次**build**的过程中，根据你定义的`Table`,自动生成一个数据表操作类。

除了包含基本的 `create` `save` `update` `validate`方法以外,

比较有意思的部分是， 

`frog`会根据你定义的`Table`里`Field`的索引设置，生成对应的查询方法。

如：

```
Field.name('title').char(64),
Field.name('category').tinyint(true).index()
```
型如上面这样的定义，会生成一个 `fetchByCategory()`的方法，

但**不会**生成`fetchByTitle()`

这从一定程度上避免了通过**非索引**字段来查询数据库引起的**慢查询**。

