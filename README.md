# shogi-server

フラッドゲートの将棋サーバーを突っついて勉強だぜ（＾～＾）  

[shogi-server.git](http://git.sourceforge.jp/view?p=shogi-server/shogi-server.git;a=summary)  
`2020-12-06	Daigo Moriwaki	[shogi-server] Bump up the revision to 20201206 `  
👆 これを持ってきたぜ（＾～＾）  

## Run

```shell
# ここに置いておくとするぜ（＾～＾）
cd c:\GitHub\shogi-server

docker build . -t muzudho/shogi-server

docker images

docker run -p 4081:4081 -e TZ=Asia/Tokyo -d muzudho/shogi-server

docker ps

# テストをするために Dockerコンテナに入れだぜ（＾～＾）
docker exec -it <CONTAINER ID> /bin/bash

cd test

ruby TC_ALL.rb
```

## References

* [https://shogi-server.osdn.jp/](https://shogi-server.osdn.jp/)
