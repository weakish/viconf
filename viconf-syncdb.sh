#!/bin/sh

set -e

readonly config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
readonly viconf_config="$config_home/viconf/config"
readonly viconf_repo_user="weakish"

readonly api_version="Accept: application/vnd.github.v3+json"
readonly api_raw="Accept: application/vnd.github.v3.raw"
readonly api_root="https://api.github.com/repos/weakish/viconf/contents"

get_file_content() {
    local file_name=$1
    local output_file=$2
    curl --silent --header "$api_raw" "$api_root/$file_name" > $output_file
}

if [ -f $viconf_config ]; then
    readonly current_sha1=$(git hash-object $viconf_config)
    upstream_sha1() {
        curl --silent --header "$api_version" $api_root/config |
        jq '.sha'
    }
    if [ $current_sha1 = $(upstream_sha1) ]; then
        exit 0
    else
        mv $viconf_config $viconf_config.backup
        sort $viconf_config.backup > $viconf_config.current
        get_file_content config $viconf_config.upstream
        # Lines added.
        comm -13 $viconf_config.current $viconf_config.upstream > $viconf_config.patch
        cat $viconf_config.patch >> $viconf_config.current

        sort $viconf_config.current > $viconf_config
    fi
else
    get_file_content config $viconf_config
fi
