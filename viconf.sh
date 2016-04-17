#!/bin/sh
# by Jakukyo Friel <weakish@gmail.com> under Apache-v2.

command=$1
meta_config="$HOME/.config/viconf/config"
command_record=$(grep "^$command," $meta_config)
if [ -z "$command_record" ]; then
  echo "We do not know $command."
  echo 'Please add it via `viconf viconf`.'
  exit 69  # EX_UNAVAILABLE
fi

command_config=$(echo $command_record | cut -d',' -f2)
export config_file=$HOME/$command_config
temp_config_file=$(tempfile)
command_check=$(echo $command_record | cut -d',' -f3-)


viconf_edit () {
  if ${first_editing:-true}; then
    cat $config_file > $temp_config_file
  fi
  editor $temp_config_file
  ${command_check:-viconf-check} $temp_config_file

  if [ $? -eq 0 ]; then
    cat $temp_config_file > $config_file
    # We don't use `mv`, since if $config_file is a symbolic link, `mv` will overrides it.
  else
    first_editing=false
    echo
    echo 'There is something wrong with the syntax.'
    read -p 'Edit it again?(Y/n):' user_response
    case $user_response in
      n|N)
        echo
        echo 'Due to syntax error, we will not update your config file.'
        echo 'You can find your edits in' $temp_config_file ;;
      *) viconf_edit ;;
    esac
  fi
}


viconf_edit


# post-hook example
#
# commit in git repo
#
# Usage: viconf command 'commit message'
#
# cd $HOME/dotfiles/
# git commit -m $2

