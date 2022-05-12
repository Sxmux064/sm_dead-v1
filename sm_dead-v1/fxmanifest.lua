fx_version 'cerulean'
game 'gta5'
author 'ł S#0440' -- don't remove this pls.
description 'Automatic faction system script, compile the config and it will create everything in the database for you automatically. Compatible with ox_inventory and fivem-appearance'
version '1.0'

client_scripts {
    'config.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/*.lua'
}