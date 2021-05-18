#!/bin/sh

# Please use LF for line breaks.

cd /shogi-server

# logsディレクトリは１階層目に置くようだぜ（＾～＾）絶対パスで指定するぜ（＾～＾）
ruby shogi-server --daemon /logs --max-identifier $MAX_IDENTIFIER $EVENT $PORT & tail -F /logs/shogi-server.log
