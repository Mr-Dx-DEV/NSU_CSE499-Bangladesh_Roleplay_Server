fx_version 'cerulean'
game 'gta5'

description 'SJRP-Spawn'
version '1.0.0'

shared_scripts {
	'config.lua',
	'@sjrp-houses/config.lua',
	--[[ '@sjrp-apartments/config.lua' ]]
}

client_script 'client.lua'
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
	'html/reset.css'
}

lua54 'yes'
