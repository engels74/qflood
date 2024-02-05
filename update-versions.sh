#!/bin/bash
workflow_url="https://api.github.com/repos/jesec/flood/actions/workflows/publish-rolling.yml/runs?status=success&branch=master"
flood_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "${workflow_url}" | jq -re '.workflow_runs[0].id') || exit 1
full_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -re '. | "release-\(.qbittorrent)_v\(.libtorrent_2_0)"') || exit 1
version=$(sed -e "s/release-//g" -e "s/_.*//g" <<< "${full_version}")
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg full_version "${full_version}" \
    --arg flood_version "${flood_version}" \
    '.version = $version | .full_version = $full_version | .flood_version = $flood_version' <<< "${json}" | tee VERSION.json
