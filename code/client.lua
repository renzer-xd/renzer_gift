ESX               = nil 
Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
	PlayerData = ESX.GetPlayerData() 
end) 

local button = false

Citizen.CreateThread(function()
	local Config1 = Config.Zone.Gift
	local blip1 = AddBlipForCoord(Config1.Pos.x, Config1.Pos.y, Config1.Pos.z)
	SetBlipSprite (blip1, Config1.Blip.Id)
	SetBlipDisplay(blip1, 4)
	SetBlipScale  (blip1, Config1.Blip.Size)
	SetBlipColour (blip1, Config1.Blip.Colour)
	SetBlipAsShortRange(blip1, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config1.Blip.Name)
	EndTextCommandSetBlipName(blip1)
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.Zone) do
            if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 6.0) then
                DrawaSher3DText(v.Pos.x, v.Pos.y, v.Pos.z+ 1.1, v.Text.Title)
            end
            if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) then
                if not button then
                    DisplayHelpText('กด ~y~G  ~w~เพื่อรับ ~g~ของขวัญ')
                end
                if IsControlJustPressed(0, Config.Key['G']) and not button then
                    button = true
                    ESX.TriggerServerCallback('renzer_gift:checksql', function(check)
                        if check == 0 then 
                            exports.pNotify:SendNotification({
                                text = "ยินดีต้อนรับสู่WanGan",
                                type = "success",
                                timeout = 3000,
                                layout = "centerLeft",
                                queue = "left"
                            })
                            TriggerServerEvent('renzer_gift:additem')
                            TriggerServerEvent('renzer_gift:addMoney')
                        else 
                            exports.pNotify:SendNotification({
                                text = "คุณรับของขวัญไปแล้ว",
                                type = "success",
                                timeout = 3000,
                                layout = "centerLeft",
                                queue = "left"
                            })
                        end
                    end)
                end
            end
        end
    end
end)



DisplayHelpText = function(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString('<font face="sarabun"><b>'..str..'</b></font>')
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterFontFile('sarabun')
fontId1 = RegisterFontId('sarabun')
function DrawaSher3DText (x,y,z, text)

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0, 0.7)
    SetTextFont(fontId1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextDropShadow()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 200
    -- DrawRect(_x,_y+0.0200, 0.040+ factor, 0.03, 55,55,55, 170)
  end