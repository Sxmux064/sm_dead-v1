fx_version 'cerulean'
game 'gta5'
author 'ł S#0440' -- don't remove this pls.
description 'Death System v1, compatibile with ox_inventory. dependecies es_extended'
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
