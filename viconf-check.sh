#!/bin/sh

diff -u $config_file $1
read -p 'Review your changes. Do you want to save it?[Y/n]:' save_it
case $save_it in
  n|N) exit 1 ;;
  *) exit 0 ;;
esac
