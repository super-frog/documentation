### 依赖注入
前面的例子太长了，这一节我们换个短一点的。

```javascript
//一个echo接口
const Input = {
  //输入词 string:1,16 in:query require
  word:'some word'
};

module.exports = async (Input) => {
  return Input.word;
};

```

表面上看来是把上面定义的 `Input` 作为 `async function`的参数传入，

实际上并不是，不然关于入参提取、校验又是如何处理的呢？

`frog`会根据**对象字面量`Input`**, 自动生成入参的处理类：

```javascript
//这个类的代码是自动生成的，你了解 AST 吗？
class Input {
  constructor(){
    ...
  }

  static fromRequest(req){
    ...
  }
}
```

是的，`async function`里的`Input`其实是这个类的实例，而 **并不是Input对象字面量** ！

这一点很重要，`frog`通过这样的方式，在底层注入了这个参数。

> 把 **对象字面量** 就近定义，并不会引起混乱。

> 反而会因此得到很好的编辑器**代码提醒**, 这都是基于实践启发的设计。