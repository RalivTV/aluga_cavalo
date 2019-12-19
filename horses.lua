RegisterNetEvent('horse')
AddEventHandler('horse', function(source, args) 
	CreateThread(function()
	        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, 0.5))
            local hash = GetHashKey("A_C_Horse_AmericanPaint_Greyovero")
            RequestModel(hash)
            local horse = CreatePed(hash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
            TaskWanderStandard(horse, 10.0, 10.0)
            Citizen.InvokeNative(0x283978A15512B2FE, horse, true)
			Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, horse)
            TaskGoStraightToCoord(horse) --horse blip
            print("Funciona")	
	end)
end)

local blips = {
   {title="valentine", id=1560611276, x=-384.32, y=746.93, z=115.53},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = Citizen.InvokeNative(0x554d9d53f696d002, info.id, info.x, info.y, info.z)
    end      
end)


Citizen.CreateThread(function()
    WarMenu.CreateMenu('cav', "cavalos")
    WarMenu.SetSubTitle('cav', 'Alugue seu servico')
    WarMenu.CreateSubMenu('ped', 'cav', 'cavalos')

    while true do


        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('cav') then

            if WarMenu.MenuButton('Estão disponíveis', 'ped') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('ped') then
            if WarMenu.Button('Chama 1 cavalo 2 $') then
                TriggerServerEvent("buy:cav", 20) 
            end

            WarMenu.Display()
        elseif (Vdist(coords.x, coords.y, coords.z, -384.32, 746.93, 115.53) < 2.0) then
               TriggerEvent("enter:cav")
             if whenKeyJustPressed(keys["ENTER"]) then
                WarMenu.OpenMenu('ped')
               end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('cancel')
  AddEventHandler('cancel', function()
    SetTextScale(0.5, 0.5)
    local msg = "Tu não tens dinheiro que chegue !!!"
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  end)

RegisterNetEvent('enter:cav')
  AddEventHandler('enter:cav', function()
    SetTextScale(0.5, 0.5)
    local msg = "Press Enter para abrir o menu"
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  end)

RegisterNetEvent('loadcav')
AddEventHandler('loadcav', function(horse) 
    TriggerEvent("horse", true)
end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end