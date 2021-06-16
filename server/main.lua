RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("mbl_emotes:server:ServerEmoteRequest")
AddEventHandler("mbl_emotes:server:ServerEmoteRequest", function(target, emotename, etype)
	TriggerClientEvent("mbl_emotes:client:ClientEmoteRequestReceive", target, emotename, etype)
end)

RegisterServerEvent("mbl_emotes:server:ServerValidEmote") 
AddEventHandler("mbl_emotes:server:ServerValidEmote", function(target, requestedemote, otheremote)
	TriggerClientEvent("mbl_emotes:client:SyncPlayEmote", source, otheremote, source)
	TriggerClientEvent("mbl_emotes:client:SyncPlayEmoteSource", target, requestedemote)
end)



RLCore.Functions.CreateCallback('mbl_emotes:server:getCharacterEmoteBinds', function(source, cb)
    local _src = source
    local _char = RLCore.Functions.GetPlayer(_src)
    local _citizenid = _char.PlayerData.citizenid
	local bindData = exports.ghmattimysql:executeSync("SELECT `emoteBinds` FROM `players` WHERE `citizenid` = @citizenid", {['@citizenid'] = _citizenid})
	if bindData ~= nil then
		local bindDataFinal = json.decode(bindData)
		cb(bindDataFinal)
	else
		cb(nil)
	end
end)

RLCore.Functions.CreateCallback('mbl_emotes:server:updateCharacterEmoteBinds', function(source, cb, keybinds)
	local _src = source
	if keybinds ~= nil then
		local _char = RLCore.Functions.GetPlayer(_src)
		local _citizenid = _char.PlayerData.steam
		local newKeybinds = json.encode(keybinds)
		print(newKeybinds)
		exports.ghmattimysql:execute("UPDATE `players` SET `emoteBinds` = @emoteBinds WHERE `steam` = @citizenid", {['@emoteBinds'] = newKeybinds, ['@citizenid'] = _citizenid}, function(updated)
			if updated > 0 then
				cb(true)
			else
				cb(false)
			end
		end)
	else
		cb(false)
	end
end)

RLCore.Commands.Add("emotebind", "QYNİN ANASINI SİK", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
	if args[1] ~= nil and args[2] ~= nil then
		TriggerClientEvent('mbl_emotes:client:updateBindedEmotes', source, args[1], args[2])
	else
		TriggerClientEvent("RLCore:Notify", source, "Tüm argümanlar doldurumalıdır.")
    end
end)



RLCore.Commands.Add("e", "Bir animasyon yap", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
	if args[1] ~= nil then
		TriggerClientEvent('mbl_emotes:client:doAnEmote', source, args[1])
	else
		TriggerClientEvent("RLCore:Notify", source, "Tüm argümanlar doldurumalıdır.")
	end
end)