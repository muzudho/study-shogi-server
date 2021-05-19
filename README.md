# shogi-server

フラッドゲートの将棋サーバーを突っついて勉強だぜ（＾～＾）  

[shogi-server.git](http://git.sourceforge.jp/view?p=shogi-server/shogi-server.git;a=summary)  
`2020-12-06	Daigo Moriwaki	[shogi-server] Bump up the revision to 20201206 `  
👆 これを持ってきたぜ（＾～＾）  

## Portについて

CSAの純正のCSAプロトコルでWCSCにつなぐときは 将棋所の無印 `サーバー通信対局...` を使えだぜ（＾～＾）ポート番号は 4081（＾～＾）  
floodgateの拡張CSAプロトコルでFloodgateにつなぐときは 将棋所の `サーバー通信対局(floodgate)...` を使えだぜ（＾～＾）ポート番号は 4000（＾～＾）  
コードのユニットテストを走らせるときは ポート番号 4000 を使ってるぜ（＾～＾）  

## Test

```shell
# ここに置いておくとするぜ（＾～＾）
cd c:\GitHub\shogi-server

docker build . -t muzudho/shogi-server-test -f Dockerfile-test

docker images

# テストしたいときは 4000番ポート（＾～＾）
docker run -d -p 4000:4000 -e "TZ=Asia/Tokyo" muzudho/shogi-server-test

docker ps

# テストをするために Dockerコンテナに入れだぜ（＾～＾）
docker exec -it <CONTAINER ID> /bin/bash

# もしサーバーが立っていなければ（＾～＾）
# ruby shogi-server hoge 4000 &

cd test

ruby TC_ALL.rb

exit
```

## Run

```shell
# ここに置いておくとするぜ（＾～＾）
cd c:\GitHub\shogi-server

docker build . -t muzudho/shogi-server

docker images

# 将棋所から接続したいときは 4081番ポート（＾～＾）
docker run -d -p 4081:4081 -e "TZ=Asia/Tokyo" muzudho/shogi-server

docker ps

# 調べたけりゃ Dockerコンテナに入れだぜ（＾～＾）
docker exec -it <CONTAINER ID> /bin/bash

exit
```

## Stop

```shell
docker ps

docker stop <CONTAINER ID>
```

## Vmmem

Dockerを使っているときに大量にメモリを占有されるぜ（＾～＾）花見の場所取りみたいなもんだな（＾～＾）  

```shell
# Vmmemが嫌になったら、強制終了（＾～＾）
wsl --shutdown
```

## References

* [https://shogi-server.osdn.jp/](https://shogi-server.osdn.jp/)
