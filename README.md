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
# テストのとき
# docker build . -t muzudho/shogi-server-test -f Dockerfile-test

docker images

# 将棋所から接続したいときは 4081番ポート（＾～＾）
docker run -p 4081:4081 -e TZ=Asia/Tokyo -d muzudho/shogi-server
# テストしたいときは 4000番ポート（＾～＾）
# docker run -p 4000:4000 -e TZ=Asia/Tokyo -d muzudho/shogi-server-test

docker ps

# テストをするために Dockerコンテナに入れだぜ（＾～＾）
docker exec -it <CONTAINER ID> /bin/bash

# なんか将棋サーバー立ってないので、立てろだぜ（＾～＾）ただし、この立て方は本番用ではなく、テストの一時用な（＾～＾）
ruby shogi-server hoge 4000 &
jobs
[1]+  Running                 ruby shogi-server hoge 4000 &

cd test

ruby TC_ALL.rb

exit
```

## Stop

```shell
docker ps

docker stop <CONTAINER ID>
```

## References

* [https://shogi-server.osdn.jp/](https://shogi-server.osdn.jp/)
