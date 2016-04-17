require 'shelljs/make'

target.all = ->
  do target.install
  do target.updatedb

config_home = env.XDG_CONFIG_HOME ? "#{env.HOME}/.config"
viconf_config = "#{config_home}/viconf/config"

target.updatedb = ->
  viconf_repo_user = "weakish"
  viconf_url = "https://github.com/#{viconf_repo_user}/viconf/raw/master/config"
  viconf_config_backup = "#{viconf_config}.backup"
  mv viconf_config, viconf_config_backup
  exec "wget -O #{viconf_config} #{viconf_url}"

target.install = ->
  bin_dest = process.argv[3] or "/usr/local/bin"
  cp "viconf.sh", "#{bin_dest}/viconf"
  cp "viconf-check.sh", "#{bin_dest}/viconf-check"
  cp "config", viconf_config
