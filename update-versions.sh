#!/bin/bash
set -exuo pipefail

# Fetch the flood version
version_flood=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/jesec/flood/releases/latest" | jq -re .tag_name)

# Fetch libtorrent v1 and v2 versions
full_version_lib1=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -re '. | "release-\(.qbittorrent)_v\(.libtorrent_1_2)"')
build_revision_lib1=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${full_version_lib1}/dependency-version.json" | jq -re '.revision')
full_version_lib2=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -re '. | "release-\(.qbittorrent)_v\(.libtorrent_2_0)"')
build_revision_lib2=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${full_version_lib2}/dependency-version.json" | jq -re '.revision')
version=$(sed -e "s/release-//g" -e "s/_.*//g" <<< "${full_version_lib2}")

# Update meta.json using jq
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version}--${version_flood//v/}" \
    --arg full_version_lib1 "${full_version_lib1}" \
    --arg build_revision_lib1 "${build_revision_lib1}" \
    --arg full_version_lib2 "${full_version_lib2}" \
    --arg build_revision_lib2 "${build_revision_lib2}" \
    --arg version_flood "${version_flood//v/}" \
    '.version = $version | .full_version_lib1 = $full_version_lib1 | .build_revision_lib1 = $build_revision_lib1 | .full_version_lib2 = $full_version_lib2 | .build_revision_lib2 = $build_revision_lib2 | .version_flood = $version_flood' <<< "${json}" | tee meta.json
