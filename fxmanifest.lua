fx_version "cerulean"

description "DuCity Draw"
author "DuCity"
version '1.0.0'

lua54 'yes'

games {
  "gta5",
}

shared_scripts {
  "config/**/*",
}
client_script {
  '@PolyZone/client.lua',
  "client/**/*",
}
server_script "server/**/*"

dependency {
  "qb-core",
  "qb-menu",
  "qb-target",
  "PolyZone"
}
