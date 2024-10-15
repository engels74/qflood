#!/bin/bash

# Fetch the full version with the "release-" prefix
full_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -re '. | "release-\(.qbittorrent)_v\(.libtorrent_2_0)"') || exit 1
[[ -z ${full_version} ]] && exit 0
[[ ${full_version} == null ]] && exit 0

# Fetch the flood version
flood_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/jesec/flood/releases/latest" | jq -re .tag_name) || exit 1
[[ -z ${flood_version} ]] && exit 0
[[ ${flood_version} == null ]] && exit 0

# Update VERSION.json using jq
json=$(cat VERSION.json)
jq --sort-keys \
    --arg full_version "${full_version}" \
    --arg flood_version "${flood_version//v/}" \
    '.version = ($full_version | sub("^release-"; "") + "--" + $flood_version) |
     .full_version = $full_version |
     .flood_version = $flood_version' <<< "${json}" | tee VERSION.json
