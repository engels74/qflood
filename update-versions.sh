#!/bin/bash
set -exuo pipefail

workflow_url="https://api.github.com/repos/jesec/flood/actions/workflows/publish-rolling.yml/runs?status=success&branch=master"
version_flood=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "${workflow_url}" | jq -re '.workflow_runs[0].id')
full_version_lib1=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -re '. | "release-\(.qbittorrent)_v\(.libtorrent_1_2)"')
build_revision_lib1=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${full_version_lib1}/dependency-version.json" | jq -re '.revision')
full_version_lib2=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -re '. | "release-\(.qbittorrent)_v\(.libtorrent_2_0)"')
build_revision_lib2=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${full_version_lib2}/dependency-version.json" | jq -re '.revision')
version=$(sed -e "s/release-//g" -e "s/_.*//g" <<< "${full_version_lib2}")
combined_version="${version//v/}--${version_flood}"
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${combined_version}" \
    --arg full_version_lib1 "${full_version_lib1}" \
    --arg build_revision_lib1 "${build_revision_lib1}" \
    --arg full_version_lib2 "${full_version_lib2}" \
    --arg build_revision_lib2 "${build_revision_lib2}" \
    --arg version_flood "${version_flood}" \
    '.version = $version | .full_version_lib1 = $full_version_lib1 | .build_revision_lib1 = $build_revision_lib1 | .full_version_lib2 = $full_version_lib2 | .build_revision_lib2 = $build_revision_lib2 | .version_flood = $version_flood' <<< "${json}" | tee meta.json
