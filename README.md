# TonyApp

+ 用户登录
+ 网站访问信息（注册用户数，陌生用户数及浏览时长）

## 设计

*Q. 如何实现用户登录以及登录时长？*

使用 `devise`；登录时长 = `Time.now - current_user.current_sign_in_at`

*Q. 如何区分陌生用户？*

User-Agent + IP ?

*Q. 如何记录陌生用户的浏览时长？*

+ 系统维护一层缓存，记录为每个陌生用户分配的 stranger_id
  - 用户第一次访问站点时，系统自动分配 stranger_id，并连同 created_at 写入 Cookie。
  - 用户在随后刷新页面时，系统检查 stranger_id 是否存在，并且通过 first_visited_at 得到用户的浏览时长。
+ 缓存的过期策略，可以有几种：
  1. 使用 WebSocket 协议，在用户 on_close 时将该 stranger_id 清掉
  2. Ajax 轮询，每 {T} 时长变向服务器发送 ping 信息，当然缓存中需要记录相应 last_ping 信息，定期过久的 last_ping 对应的 stranger_id 清掉
  3. 固定时长，在缓存中增加记录 stranger_id 的 created_at，将过久的 stranger_id 清空
+ 何时检查缓存的过期：
  + 每次页面访问时
  + 定时任务

时间原因，暂时采取简单粗暴策略 3，并在每次页面访问时清理缓存。

## 实现

## 部署

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

