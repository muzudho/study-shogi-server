#!/bin/sh

# Please use LF for line breaks.

cd /shogi-server

# パスを絶対パスにしないといけなくなってしまった（＾～＾）
ruby shogi-server --daemon /shogi-server/logs --max-identifier $MAX_IDENTIFIER $EVENT $PORT & tail -F /shogi-server/logs/shogi-server.log
