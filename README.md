# shogi-server

フラッドゲートの将棋サーバーを突っついて勉強だぜ（＾～＾）  

[shogi-server.git](http://git.sourceforge.jp/view?p=shogi-server/shogi-server.git;a=summary)  
`2020-12-06	Daigo Moriwaki	[shogi-server] Bump up the revision to 20201206 `  
👆 これを持ってきたぜ（＾～＾）  

## Portについて

CSAの純正のCSAプロトコルでWCSCにつなぐときは 将棋所の無印 `サーバー通信対局...` を使えだぜ（＾～＾）ポート番号は 4081（＾～＾）  
floodgateの拡張CSAプロトコルでFloodgateにつなぐときは 将棋所の `サーバー通信対局(floodgate)...` を使えだぜ（＾～＾）ポート番号は 4000（＾～＾）  
コードのユニットテストを走らせるときは ポート番号 4000 を使ってるぜ（＾～＾）  

## Run a server


```shell
# ここに置いておくとするぜ（＾～＾）
cd c:\GitHub\shogi-server

docker build . -t muzudho/shogi-server

docker images

# 将棋所から接続したいときは 純正CSAプロトコルなら 無印サーバー通信対局で 4081番、
docker run -d -p 4081:4081 -e "TZ=Asia/Tokyo" muzudho/shogi-server
# 拡張CSAプロトコルなら floodgateモードで 4000番ポート（＾～＾） テストも4000番ポート（＾～＾）
# docker run -d -p 4000:4081 -e "TZ=Asia/Tokyo" muzudho/shogi-server

# docker ps
#
# # 調べたけりゃ Dockerコンテナに入れだぜ（＾～＾）
# docker exec -it <CONTAINER ID> /bin/bash
#
# # テストしたけりゃ、やれだぜ（＾～＾）
# cd test
# ruby TC_ALL.rb
#
# exit
```

## Test

サーバーが立っている間に行ってください。（もしかすると別のDockerコンテナで立てたサーバーを見に行ってないかもしれません）  

Dockerコンテナの中で `localhost` を指すと そのDockerコンテナ自身を指してしまい、  
別のDockerコンテナで動いている 将棋サーバー を指せませんので、いくつかのテストがエラーになります。  
全てのテストを正しく行うには、 将棋サーバー が立っているDockerコンテナに入って `cd test`、 `ruby TC_ALL.rb` してください。  

```shell
# ここに置いておくとするぜ（＾～＾）
cd c:\GitHub\shogi-server

docker build . -t muzudho/shogi-server-test -f Dockerfile-test

docker images

# Dockerマシンのログを見ろだぜ（＾～＾）文字に色付いてなくて おもんないけどな（＾～＾）
docker run -d -e "TZ=Asia/Tokyo" muzudho/shogi-server-test

# docker ps
#
# # テストをするために Dockerコンテナに入れだぜ（＾～＾）
# docker exec -it <CONTAINER ID> /bin/bash
#
# # この Dockerコンテナの中で サーバー立ててもいいしな（＾～＾）
# # ruby shogi-server hoge 4000 &
#
# cd test
# ruby TC_ALL.rb
#
# exit
```

## Stop a server

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

## Make doc

```shell
# ここに置いておくとするぜ（＾～＾）
cd c:\GitHub\shogi-server

make doc
```

## References

* [https://shogi-server.osdn.jp/](https://shogi-server.osdn.jp/)
