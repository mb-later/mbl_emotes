fx_version 'bodacious'
games {'gta5'}

description 'PixelWorld Emotes'
name 'PixelWorld: mbl_emotes'
author 'PixelWorldRP [Dr Nick]'
version 'v1.0.0'
url 'https://www.PixelWorldrp.com'

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/animationList.lua',
	'client/main.lua',
}

dependencies {
	"mbl_interact"
}
