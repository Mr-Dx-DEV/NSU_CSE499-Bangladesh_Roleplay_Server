fx_version 'cerulean'
game 'gta5'

author 'Snipe'
description 'QB-CryptoMining'
version '1.0.0'

shared_script 'config.lua'

server_scripts {
	'config.lua',
	'server.lua'
}
client_scripts {
	'config.lua',
	'client.lua'
}

dependency 'sjfw'

lua54 'yes'