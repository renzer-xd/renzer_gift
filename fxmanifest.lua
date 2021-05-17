fx_version 'adamant'

game 'gta5'

description 'renzer_gift By:RenZerXD'

version '1.0'

client_script { 
    'config.lua',
    'code/client.lua',
    'code/npc.lua'
    
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'code/server.lua'
}

dependency 'es_extended'
