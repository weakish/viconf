#!/bin/sh

viconf_url=https://github.com/weakish/viconf/raw/master/config
viconf_config=$HOME/.config/viconf/config
mv $viconf_config $viconf_config.backup
wget -O $viconf_config $viconf_url
