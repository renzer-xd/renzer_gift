Citizen.CreateThread(function()
    for k,v in pairs(Config.Zone) do
      RequestModel(GetHashKey(v.Npc.npcname))
      while not HasModelLoaded(GetHashKey(v.Npc.npcname)) do
        Wait(1)
      end
	  
      ped =  CreatePed(4, v.Npc.npcped,v.Pos.x,v.Pos.y, v.Pos.z-1, 3374176, false, true)
      SetEntityHeading(ped, v.Pos.h)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	  end	
end)