#!/bin/sh

# Please use LF for line breaks.

# テストで使うlogsディレクトリは１階層目に置くようだぜ（＾～＾）空の shogi-server.log ファイルも作っておいてしまおう（＾～＾）
touch /logs/shogi-server.log

cd /shogi-server

# サーバーが使うlogsディレクトリは、テストで使うlogsディレクトリとは別の場所にしよう。ややこしいんで絶対パスで指定するぜ（＾～＾）
ruby shogi-server --daemon /shogi-server/logs --max-identifier $MAX_IDENTIFIER $EVENT $PORT & tail -F /shogi-server/logs/shogi-server.log
