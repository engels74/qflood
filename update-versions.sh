#!/bin/bash

workflow_url="https://api.github.com/repos/jesec/flood/actions/workflows/publish-rolling.yml/runs?status=success&branch=master"
latest_run_id=$(curl -u "${GITHUBACTOR}:${GITHUBTOKEN}" -fsSL "${workflow_url}" | jq -r '.workflow_runs | .[0].id')
[[ -z ${latest_run_id} ]] && exit 0

flood_version="${latest_run_id}"
[[ -z ${flood_version} ]] && exit 0

qbittorrent_full_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -r '. | "release-\(.qbittorrent)_v\(.libtorrent_2_0)"')
qbittorrent_version=$(echo "${qbittorrent_full_version}" | sed -e "s/release-//g" -e "s/_.*//g")
[[ -z ${qbittorrent_version} ]] && exit 0

version="${qbittorrent_version}--${flood_version}"
version_json=$(cat ./VERSION.json)
jq '.version = "'"${version}"'" | .qbittorrent_version = "'"${qbittorrent_version}"'" | .qbittorrent_full_version = "'"${qbittorrent_full_version}"'" | .flood_version = "'"${flood_version}"'"' <<< "${version_json}" > VERSION.json
