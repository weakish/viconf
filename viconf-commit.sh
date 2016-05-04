#!/bin/sh

set -e
config_repo="${CONFIG_REPO:-$HOME/lib}"
command="$1"
meta_config="$HOME/.config/viconf/config"
command_record="$(grep "^$command," $meta_config)"
command_config="$(echo $command_record | cut -d',' -f2)"
config_file="$HOME/$command_config"
cp "$config_file" "$config_repo/$command_config"
cd "$config_repo"
git commit --verbose --gpg-sign "$command_config"
