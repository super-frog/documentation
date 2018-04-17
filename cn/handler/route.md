### 路由

代码示例:

```javascript
router.group('event').use('auth')
  .post('', 'create_event')    // match: POST /event
  .put('/{ID}', 'update_event'); // match: PUT /event/123

router.reset().group('event')
  .get('', 'get_event_list') // match: GET /event
  .get('{ID}' 'get_event_profile');  // match: GET /event/123
```

`frog` 路由非常直白， 

> route[ .use({ **middleware** }) ].{ **method** }('{ **path** }', '{ **handler** }')

一个推荐的技巧是，同一个 **group** 下，或经过同一个 **中间件** 的路由，

可以以链式的方式声明，这样可以让代码有更好的可读性。

你也可以使用`reset`重置一个路由组，

比如上面的例子，第二组路由不需要经过`auth`中间件。

