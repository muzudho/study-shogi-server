# Shogi-server プロジェクトの日本語訳

将棋サーバープロジェクトでは、将棋サーバーやレーティングツールなどを開発しています。  

## Shogi-server

将棋サーバは、[コンピュータ将棋協会](http://www.computer-shogi.org/index_e.html)が定めたサーバプロトコルVer1.2.1を実装したサーバです。  
コンピュータ将棋協会が定義したコンピュータ将棋の対局を行うためのサーバです。  

### 事前に必要なもの

Ruby 2.1以降

Debianの場合  

```shell
$ sudo aptitude install ruby
```

### インストール

```shell
$ git clone git://git.sourceforge.jp/gitroot/shogi-server/shogi-server.git
```

Shogi-serverを動かすためには、以下のファイルが必要です:  

* shogi-server
* shogi_server.rb
* shogi_server/**/*.rb

### 実行

例:

CSAプロトコルV1.2以降でサーバーを動作させる  

```shell
$ ./shogi-server hoge 4000
```

CSAプロトコルV1.1.2以前のもの  

```shell
$ ./shogi-server --max-moves 0 --least-time-per-move 1 hoge 4000
```

他にも「shogi-server」ファイルに書かれているものがあります。  

## その他のツール

各ソースファイルの先頭にあるドキュメントを参照してください。  

* mk_rate
* mk_html

## テスト

サーバーの起動  

```shell
$ ./shogi-server hoge 4000
```

テストケースの実行  

```shell
$ cd test
$ ruby TC_ALL.rb
```

```plain
Tested:

- ruby 2.0.0p481 (2014-05-08 revision 45883) [universal.x86_64-darwin13]
  Finished in 55.025733 seconds.
  383 tests, 1370 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
  100% passed
  6.96 tests/s, 24.90 assertions/s
  ruby TC_ALL.rb  1.97s user 0.34s system 4% cpu 55.424 total
```

---

2015-01-17  Daigo Moriwaki <daigo at debian dot org>  
