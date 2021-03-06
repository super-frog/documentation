### 入参处理

`frog`的宗旨是**重复的工作交给自动化来做**，

所以像**入参处理**这样的重复、繁琐的工作，当然要换一种更优雅的方式来做。

我们从上一节的例子里截取一段代码：

```javascript
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
```

`frog` 采取 **声明字面量** 的方式来定义入参处理。

上面的例子里，表示的是 

**name**属性取自**body.name**，类型为**字符串**，长度在**1-64**之间，默认值**"unamed"**

其他的属性同理，`frog`会在每一次 **build** 时，

会生成一个 **入参处理** 的类。

![](https://camo.githubusercontent.com/980a7e9cb440f703ebd198d2c0278e7936f70985/687474703a2f2f626c756573746573742e6f73732d636e2d7368616e676861692e616c6979756e63732e636f6d2f67656e5f6f626a6563742e706e67)

>在这一节我们不要太担心这个类生成出来是什么样子的，因为我们并不会直接用到它。

>后面关于**依赖注入** 以及 **代码生成** 章节，会介绍到`frog`底层是如何使用这个类的。

>这一节我们只需要记住怎么去定义**入参处理**就行了。

#### 回到正题

我们还是要说一下怎么去定义一个参数的处理方式 

```javascript
  {
    //{中文名字} {类型}:{下限},{上限} in:{参数位置} [key:{别名}] [require]
    {键名}:{默认值}
  }
```
对比一下例子里的写法，你大概就能明白每个位置所表达的含义。

- 中文名字

  用于自动生成文档时的参数名字提示语，也可以用于前端展示的label。

- 类型

  参数的数据类型，string, number, []string, []number, enum{..}, []enum{...}

- 下限,上限

  对应字符串的长度，或数字类型的大小。
  
  如果类型是数组类型，则对应的是元素的个数。
  此时，你可以再声明一组上下限表达元素的范围，
  如 []number:0,10:18,60  表示数组长度0-10，元素取值范围18-60.

- 参数位置

  确定属性从哪里获取，一般有 body, query, params, headers
  
  也支持多级， in:body.title 

- 别名

  上面只定义了参数所在的位置，默认会用字面量的属性key去检索，
  
  如果你想使用别名，如： 参数位置在  body.user_mobile
  你希望扁平化后使用简单一点的 'mobile',可以这样做
  
  ```javascript
    {
      //电话 string:11,11 in:body key:user_mobile
      mobile:'',
    }
  ```

- [require]

  是否必填

- 键名

  写代码时使用的 **key** 名字。

- 默认值

  无法正常获得参数时的默认值，默认值同样收到取值范围约束。