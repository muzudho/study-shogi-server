#!/bin/sh

# Please use LF for line breaks.

# あとで --daemon で指定したディレクトリに、ログだけでなく、さまざまなファイルが出力されるぜ（＾～＾）
# テストではファイルの出力先を shogi-server ディレクトリに合わせておく必要があるぜ（＾～＾）
cd /shogi-server

# デーモンのログ・ファイルを先に作っておいてしまおう（＾～＾）
touch shogi-server.log

# ファイル名やディレクトリ名が同じのあって　ややこしいんで絶対パスで指定するぜ（＾～＾）
ruby shogi-server $EVENT $PORT --daemon /shogi-server --max-identifier $MAX_IDENTIFIER

# Dockerを常駐させておくためだけの無限ループだぜ（＾～＾）
tail -f ./shogi-server.log
