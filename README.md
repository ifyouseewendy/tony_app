# TonyApp

+ 用户登录
+ 网站访问信息（注册用户数，陌生用户数及浏览时长）

## 设计

*Q. 如何实现用户登录以及登录时长？*

使用 `devise`；登录时长 = `Time.now - current_user.current_sign_in_at`

*Q. 如何记录陌生用户，以及浏览时长？*

+ 系统维护一层缓存，记录为每个陌生用户分配的 `stranger_id`
  - 用户第一次访问站点时，系统自动分配 `stranger_id`，并连同 `first_visited_at` 写入 Cookie。
  - 用户在随后刷新页面时，系统检查 `stranger_id` 是否存在，并且通过 `first_visited_at` 得到用户的浏览时长。
+ 缓存的过期策略，可以有几种：
  1. 使用 WebSocket 协议，在用户 *on_close* 时将该 `stranger_id` 清掉
  2. Ajax 轮询，每 {T} 时长变向服务器发送 ping 信息，当然缓存中需要记录相应 `last_ping` 信息，定期过久的 `last_ping` 对应的 `stranger_id`` 清掉
  3. 固定时长，使用 expires_in 选项，将过久的 `stranger_id` 清空

时间原因，暂时采取简单粗暴策略 3，并使用由 Rails 提供的 expires_in 自动过期检查。

## 运行

```sh
bundle install --local
rails s
```

RESTful API 位于 `localhost:3000/state`


## TODO

1. 使用 Rails Cache 的 MemoryStore 和 FileStore 有问题，详细信息记录在 [https://github.com/ifyouseewendy/tony_app/blob/master/app/controllers/application_controller.rb](https://github.com/ifyouseewendy/tony_app/blob/master/app/controllers/application_controller.rb) 中的 FIXME。
2. 没有通过 Ajax 请求写好的 REST API。

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

