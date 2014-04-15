#!/bin/sh
# By Jakukyo Friel <weakish@gmail.com>, under Apache-v2.


repo_url=https://github.com/weakish/viconf
if grep -q viconf $config_file ; then
  echo
  echo "Adding entries to viconf's database?"
  echo "Consider sending a pull request. Thanks."
  echo "You can find viconf at" $repo_url
  echo
fi

diff -u $config_file $1
read -p 'Review your changes. Do you want to save it?[Y/n]:' save_it
case $save_it in
  n|N) exit 1 ;;
  *) exit 0 ;;
esac
