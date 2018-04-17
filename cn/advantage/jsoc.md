### jsoc

`frog`在每次**build**时，利用**抽象语法树**做静态分析，

从而推导出每个接口的**请求方法**、**入参**、**返回结构**。

- 请求方法

  包括了**请求路径(path)**, **方法(Method)**,

- 入参

  每个参数的**位置**、**类型**、**验证规则**等

- 返回结构

  具体就是接口返回的 json 的基本结构，以及字段的类型等信息。

> 这是一个让人振奋的尝试，弱类型JS也可以做到静态分析，有兴趣的一起研究的联系我。