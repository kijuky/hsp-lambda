FROM --platform=linux/arm64 ghcr.io/kijuky/hsp:3.7beta10-al2 AS build-lib

# json-cライブラリのビルド (yumでインストールできるバージョンが古いため）
RUN curl -LO https://github.com/Kitware/CMake/archive/refs/tags/v3.12.4.tar.gz && tar -xzf v3.12.4.tar.gz && \
    cd CMake-3.12.4 && ./bootstrap && make && make install
RUN curl -LO https://github.com/json-c/json-c/archive/refs/tags/json-c-0.18-20240915.tar.gz && tar -xzf json-c-0.18-20240915.tar.gz && \
    mkdir json-c-build && cd json-c-build && cmake ../json-c-json-c-0.18-20240915 && make

FROM --platform=linux/arm64 ghcr.io/kijuky/hsp:3.7beta10-al2 AS build-app

# ソースコードのビルド
ARG HSP_SOURCE_NAME=sample
ENV HSP_SOURCE_NAME=${HSP_SOURCE_NAME}
COPY ${HSP_SOURCE_NAME}.hsp ./
RUN hspcmp --compath=/OpenHSP-3.7beta10/common/ -d -i -u ${HSP_SOURCE_NAME}.hsp

FROM --platform=linux/arm64 ghcr.io/kijuky/hsp:3.7beta10-lambda AS runtime

# ビルドしたjson-cライブラリのコピー
COPY --from=build-lib /hsp3.7beta10/json-c-build/libjson-c.so.5.4.0 /lib64/libjson-c.so.5.4.0
RUN ln -s /lib64/libjson-c.so.5.4.0 /lib64/libjson-c.so.5

# axファイルのコピー
ARG HSP_SOURCE_NAME=sample
ENV HSP_SOURCE_NAME=${HSP_SOURCE_NAME}
COPY --from=build-app /hsp3.7beta10/${HSP_SOURCE_NAME}.ax /var/task/start.ax
