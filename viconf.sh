#!/bin/sh
# by Jakukyo Friel <weakish@gmail.com>
# under GPL v2.

command=$1
meta_config="$HOME/.config/viconf/config"
command_record=$(grep "^$command " $meta_config)
command_config=$(echo $command_record | cut -d' ' -f2)
config_file=$HOME/$command_config
temp_config_file=$(tempfile)
command_check=$(echo $command_record | cut -d' ' -f3-)

viconf_edit () {
  cat $config_file > $temp_config_file
  editor $temp_config_file
  $command_check $temp_config_file
  if [ $? -eq 0 ]; then
    mv $temp_config_file $config_file
  else
    echo 'There is something wrong with the syntax.'
    read -p 'Edit it again?(Y/n):' user_response
    case $user_response in
      n|N)
        echo 'Due to syntax error, we will not update your config file.'
        echo 'You can find your edits in' $temp_config_file ;;
      *) viconf_edit ;;
    esac
  fi
}

viconf_edit

