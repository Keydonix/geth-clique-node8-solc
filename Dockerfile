FROM keydonix/geth-poa
# Credit To: chriseth <chris@ethereum.org>

# TODO: vendor?
RUN \
  apk --no-cache --update add build-base cmake boost-dev git nodejs=8.9.3-r1 && \
  sed -i -E -e 's/include <sys\/poll.h>/include <poll.h>/' /usr/include/boost/asio/detail/socket_types.hpp && \
  git clone https://github.com/ethereum/solidity && \
  cd /solidity && \
  git checkout 7422cd737d6bd45d552ecc10c7be0274f5a2b801 && \
  cmake -DCMAKE_BUILD_TYPE=Release -DTESTS=0 -DSOLC_LINK_STATIC=1 && \
  make solc && install -s  solc/solc /usr/bin && \
  apk del sed build-base make cmake gcc g++ musl-dev curl-dev boost-dev && \
  cd / && rm -rf solidity && \
  rm -rf /var/cache/apk/*
