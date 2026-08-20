fx_version 'adamant'

game 'gta5'


shared_scripts {
	'config.lua',
	'@sjrp-weapons/config.lua' 
}

server_script 'server/main.lua'
client_scripts {
	'client/*.lua'
} 

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/app.js',
	'html/images/*.png',
	'html/images/*.jpg',
	'html/extra_images/*.png',
	'html/ammo_images/*.png',
	'html/attachment_images/*.png',
	'html/*.ttf',
	'html/*.png',
	'html/cloth/*.png',
	'html/cloth/*.svg',
}

dependency 'sjrp-weapons' 
