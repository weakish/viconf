require 'shelljs/make'

target.all = ->
  do target.install

config_home = env.XDG_CONFIG_HOME ? "#{env.HOME}/.config"
viconf_config = "#{config_home}/viconf/config"

target.install = ->
  bin_dest = process.argv[3] or "/usr/local/bin"
  cp "viconf.sh", "#{bin_dest}/viconf"
  cp "viconf-check.sh", "#{bin_dest}/viconf-check"
  cp "config", viconf_config
