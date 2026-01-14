ARG UPSTREAM_IMAGE
ARG UPSTREAM_TAG_SHA

FROM ${UPSTREAM_IMAGE}:${UPSTREAM_TAG_SHA}
EXPOSE 8080 3000
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} FLOOD_AUTH="false" WEBUI_PORTS="8080/tcp,3000/tcp" LIBTORRENT="v2"

RUN ln -s "${CONFIG_DIR}" "${APP_DIR}/qBittorrent"

RUN apk add --no-cache unzip

ARG FULL_VERSION_LIB1
ARG BUILD_REVISION_LIB1
ARG FULL_VERSION_LIB2
ARG BUILD_REVISION_LIB2
RUN curl -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${FULL_VERSION_LIB1}/aarch64-qbittorrent-nox" > "${APP_DIR}/qbittorrent-nox-lib1" && \
    chmod 755 "${APP_DIR}/qbittorrent-nox-lib1" && \
    curl -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${FULL_VERSION_LIB2}/aarch64-qbittorrent-nox" > "${APP_DIR}/qbittorrent-nox-lib2" && \
    chmod 755 "${APP_DIR}/qbittorrent-nox-lib2"

ARG VERSION_FLOOD
RUN curl -fsSL "https://nightly.link/jesec/flood/actions/runs/${VERSION_FLOOD}/flood-linux-arm64.zip" > flood.zip && \
    unzip -q flood.zip -d "${APP_DIR}/" && \
    rm -f flood.zip && \
    mv ${APP_DIR}/flood-linux-arm64 ${APP_DIR}/flood && \
    chmod 755 "${APP_DIR}/flood"

COPY root/ /
RUN find /etc/s6-overlay/s6-rc.d -name "run*" -execdir chmod +x {} +
