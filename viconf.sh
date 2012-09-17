#!/bin/sh
# by Jakukyo Friel <weakish@gmail.com>
# under GPL v2.

command=$1
meta_config="$HOME/.config/viconf/config"
command_record=$(grep "^$command " $meta_config)
command_config=$(echo $command_record | cut -d' ' -f2)
command_check=$(echo $command_record | cut -d' ' -f3-)

editor $HOME/$command_config
$command_check
