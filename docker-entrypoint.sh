#!/bin/sh

# Please use LF for line breaks.

pwd
cd /shogi-server
ruby shogi-server --daemon /logs --max-identifier $MAX_IDENTIFIER $EVENT $PORT & tail -F ./logs/shogi-server.log
