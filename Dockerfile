FROM debian:stretch-slim

# 2020-12-06版より後
LABEL maintainer="Satoshi Takahashi <muzudho1@gmail.com>"
# 2020-12-06版以前
LABEL original_maintainer="Daigo Moriwaki <daigo@debian.org>"

RUN apt-get update && apt-get install -y \
        ca-certificates \
        apt-utils \
        ruby ruby-gsl

ENV EVENT local
ENV PORT 4081
ENV MAX_IDENTIFIER 32

# １階層目にディレクトリを作ります
WORKDIR /shogi-server

RUN gem install rgl

COPY . ./

EXPOSE $PORT

# CMD で１行で書くと見づらいのでファイルに分けたぜ（＾～＾）
ENTRYPOINT ["./docker-entrypoint.sh"]
