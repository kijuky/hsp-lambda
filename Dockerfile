FROM --platform=linux/arm64 ghcr.io/kijuky/hsp:3.7beta10

ENV LAMBDA_RUNTIME_DIR=/var/runtime \
    LAMBDA_TASK_ROOT=/var/task

# HSPソースコードのビルド
WORKDIR ${LAMBDA_TASK_ROOT}
ARG HSP_SOURCE_NAME=sample
ENV HSP_SOURCE_NAME=${HSP_SOURCE_NAME}
COPY ${HSP_SOURCE_NAME}.hsp ./
RUN hspcmp --compath=/OpenHSP-3.7beta10/common/ -d -i -u ${HSP_SOURCE_NAME}.hsp

# bootstrapの起動
COPY bootstrap ${LAMBDA_RUNTIME_DIR}/bootstrap
RUN chmod +x ${LAMBDA_RUNTIME_DIR}/bootstrap
ENTRYPOINT ["/var/runtime/bootstrap"]
