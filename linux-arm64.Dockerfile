ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 8080 3000
ENV FLOOD_AUTH="false" WEBUI_PORTS="8080/tcp,8080/udp,3000/tcp,3000/udp"

RUN ln -s "${CONFIG_DIR}" "${APP_DIR}/qBittorrent"

RUN apk add --no-cache unzip

ARG QBITTORRENT_FULL_VERSION
RUN curl -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${QBITTORRENT_FULL_VERSION}/x86_64-qbittorrent-nox" > "${APP_DIR}/qbittorrent-nox" && \
    chmod 755 "${APP_DIR}/qbittorrent-nox"

ARG FLOOD_VERSION
RUN curl -fsSL "https://nightly.link/jesec/flood/actions/runs/${FLOOD_VERSION}/flood-linux-x64.zip" > flood.zip && \
    unzip -q flood.zip -d "${APP_DIR}/" && \
    rm -f flood.zip && \
    mv ${APP_DIR}/flood-linux-x64 ${APP_DIR}/flood && \
    chmod 755 "${APP_DIR}/flood"

COPY root/ /
