#!/bin/sh

command=$1
template_config_file="$2"
meta_config="$HOME/.config/viconf/config"
command_record="$(grep "^$command," $meta_config)"
if [ -z "$command_record" ]; then
  echo "We do not know $command."
  echo 'Please add it via `viconf viconf`.'
  exit 69  # EX_UNAVAILABLE
fi

command_config="$(echo $command_record | cut -d',' -f2)"
export config_file="$HOME/$command_config"
temp_config_file=$(tempfile)
command_check=$(echo $command_record | cut -d',' -f3-)

viconf_edit () {
  if ${first_editing:-true}; then
    if [ -f "$config_file" ]; then
      cat "$config_file" > $temp_config_file
    else
      export config_file_is_empty=true
      if [ -n "$template_config_file" ]; then
        if [ -f "$template_config_file" ]; then
          export template_config_file=$template_config_file
          cat "$template_config_file"> $temp_config_file
        else
          echo "Error: Template file $2 does not exits!"
          exit 66  # EX_NOINPUT
        fi
      else
        echo "Config file does not exist yet."
        echo "We will create one later."
      fi
    fi
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
