#!/bin/sh


repo_url=https://github.com/weakish/viconf
if grep -q viconf $config_file ; then
  echo
  echo "Adding entries to viconf's database?"
  echo "Consider sending a pull request. Thanks."
  echo "You can find viconf at" $repo_url
  echo
fi

if [ $config_file_is_empty ]; then
    if [ -n "$template_config_file" ]; then
        diff -u $template_config_file $1
    else
        cat $1 | sed -r -e 's/^/+ /'
    fi
else
    diff -u $config_file $1
fi
read -p 'Review your changes. Do you want to save it?[Y/n]:' save_it
case $save_it in
  n|N) exit 1 ;;
  *) exit 0 ;;
esac
