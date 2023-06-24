fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Sp1ry (Sp1ry#2599)'
description 'Job de traficant de tigari, inceput din https://github.com/5Point-Resources/5p_pilotjob'

shared_scripts {
  'config.lua'
}

client_scripts {
  "serverCallbackLib/client.lua",
  'client/*.lua'
}

server_scripts {
  "serverCallbackLib/server.lua",
  "@vrp/lib/utils.lua",
  'server/*.lua'
}

ui_page 'html/index.html'

files {
  'html/*.html',
  'html/css/*.css',
  'html/js/*.js',
}