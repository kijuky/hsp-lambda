FROM --platform=linux/arm64 ghcr.io/kijuky/hsp:3.7beta10-al2 AS build

# ソースコードのビルド
ARG HSP_SOURCE_NAME=sample
ENV HSP_SOURCE_NAME=${HSP_SOURCE_NAME}
COPY ${HSP_SOURCE_NAME}.hsp ./
RUN hspcmp --compath=/OpenHSP-3.7beta10/common/ -d -i -u ${HSP_SOURCE_NAME}.hsp

FROM --platform=linux/arm64 ghcr.io/kijuky/hsp:3.7beta10-lambda AS runtime

# axファイルのコピー
ARG HSP_SOURCE_NAME=sample
ENV HSP_SOURCE_NAME=${HSP_SOURCE_NAME}
COPY --from=build /hsp3.7beta10/${HSP_SOURCE_NAME}.ax /var/task/start.ax
