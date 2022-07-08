local ESX = exports['es_extended']:getSharedObject()
local Tasti = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

--

local morto = false
local secondiR = SM.SecondToRespawn

--

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    Citizen.Wait(6000)
    ESX.TriggerServerCallback('sm_dead:checkdead', function(risultato)
        if risultato then
            Morte()
            ESX.ShowNotification("Sei morto pk hai precedentemente quittato da morto.")
        end
    end)
end)

RegisterNetEvent('esx:onPlayerDeath') -- Cosa succede quando muore un player?
AddEventHandler('esx:onPlayerDeath', function(data)
    if not morto then
        TriggerEvent("inventory:OpenInventory", false) -- così non puoi far aprire l'ox_inventory
        local sm_player = PlayerPedId()
        Citizen.Wait(500)
        ESX.UI.Menu.CloseAll() -- chiude tutti i menu.
        TriggerServerEvent("sm_dead:setdead", true) -- vedere se funge
        ClearPedTasksImmediately(sm_player)
        ClearPedBloodDamage(sm_player) -- rimuove il sangue addosso all'individuo
        NetworkResurrectLocalPlayer(GetEntityCoords(sm_player), GetEntityHeading(sm_player), false, false)
        Citizen.Wait(200)
        SetEntityHealth(sm_player, GetPedMaxHealth(sm_player))
        ClearPedTasksImmediately(sm_player)
        Morte()
    end
end)

Morte = function()
    morto = true
    local sm_player = PlayerPedId()
    NetworkResurrectLocalPlayer(GetEntityCoords(sm_player), GetEntityHeading(sm_player), false, false)
    Citizen.Wait(500)
    SetEntityHealth(sm_player, GetPedMaxHealth(sm_player))
    SetEntityInvincible(sm_player, true)
    ClearPedTasks(sm_player)
    SetCurrentPedWeapon(sm_player, GetHashKey("WEAPON_UNARMED"), true)
    Citizen.Wait(200)
    ESX.ShowNotification(SM.Languages['respwan_avviable']..math.ceil(secondiR).. " SECONDI")
    Morte_Timer()
    Morte_Testo()
    while morto do
        if not IsEntityPlayingAnim(sm_player, SM.animDict, SM.animName, 3) then
            ESX.Streaming.RequestAnimDict(SM.animDict, function()
                TaskPlayAnim(sm_player, SM.animDict, SM.animName, 1.0, 0.5, -1, 33, 0, 0, 0, 0)
            end)
        end
        Citizen.Wait(SM.ReloadDeathAnimTime)
    end
end

--

Morte_Timer = function()
    Citizen.CreateThread(function()
        while morto and secondiR > 0 do
            Citizen.Wait(1000)
            secondiR = secondiR - 1
        end
    end)
end

Morte_Testo = function ()
    local ped =  PlayerPedId()
    Citizen.CreateThread(function()
        while morto do
            Citizen.Wait(10)
            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(28)
            EnableControlAction(1, 1, true)
            EnableControlAction(1, 2, true)
            EnableControlAction(0, Tasti['T'], true)
            EnableControlAction(0, Tasti['E'], true)
            DisableControlAction(0, Tasti['X'], true)
            if secondiR > 0 then
            else
                DrawTXT(SM.Languages['click_to_respawn'],4,0.5,0.87,0.50,255,255,255,255)
                if IsControlPressed(0, Tasti[SM.KeyToRespawn]) and secondiR == 0 then
                    TriggerEvent("sm_dead:revive")
                    secondiR = SM.SecondToRespawn
                    morto = false
                    SetEntityCoords(GetPlayerPed(-1), SM.Coord_Respawn) 
                end
            end
            
        end
    end)
end

--

function DrawTXT(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

Rianima = function(playerPed)
    if SM.UseSaltyChat then
    TriggerServerEvent("sm_dead:setdead", false)
    TriggerEvent("inventory:OpenInventory", true)
    morto = false
    exports.rprogress:Stop()   
    secondiR = SM.SecondToRespawn
    StopScreenEffect('DeathFailOut')
    Coords = GetEntityCoords(playerPed)
    Heading = GetEntityHeading(playerPed)   
    SetEntityCoordsNoOffset(playerPed, Coords.x, Coords.y, Coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(Coords.x, Coords.y, Coords.z, Heading, true, false)
    TriggerServerEvent('SaltyChat_SetVoiceRange', 3.5)
    ClearPedTasksImmediately(playerPed)
    SetEntityInvincible(playerPed, false)
    ClearPedBloodDamage(playerPed)
    TriggerEvent('esx_status:set', 'hunger', 500000) -- inserisce fame e sete a metà
    TriggerEvent('esx_status:set', 'thirst', 500000) -- inserisce fame e sete a metà
    SetEntityHealth(playerPed, GetPedMaxHealth(playerPed))
    TriggerEvent('esx:onPlayerSpawn')
    else
    morto = false    
    TriggerServerEvent("sm_dead:setdead", false)
    TriggerEvent("inventory:OpenInventory", true)
    exports.rprogress:Stop()
    StopScreenEffect('DeathFailOut')
    secondiR = SM.SecondToRespawn
    Coords = GetEntityCoords(playerPed)
    Heading = GetEntityHeading(playerPed)   
    SetEntityCoordsNoOffset(playerPed, Coords.x, Coords.y, Coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(Coords.x, Coords.y, Coords.z, Heading, true, false)
    
    ClearPedTasksImmediately(playerPed)
    SetEntityInvincible(playerPed, false)
    ClearPedBloodDamage(playerPed)
    TriggerEvent('esx_status:set', 'hunger', 500000) -- inserisce fame e sete a metà
    TriggerEvent('esx_status:set', 'thirst', 500000) -- inserisce fame e sete a metà
    SetEntityHealth(playerPed, GetPedMaxHealth(playerPed))
    TriggerEvent('esx:onPlayerSpawn')
    end
end

RegisterNetEvent("sm_dead:revive")
AddEventHandler("sm_dead:revive",function()
    if morto or premorto then
    morto = false
    Rianima(PlayerPedId())
    Citizen.Wait(1000)
    Rianima(PlayerPedId())
    else
    ESX.ShowNotification(SM.Languages.['you\'re_not_dead'] ..SM.HealCommand_Label) 
    end
end)

RegisterNetEvent("sm_dead:cura")
AddEventHandler("sm_dead:cura",function()
    SetEntityHealth(PlayerPedId(), GetPedMaxHealth(PlayerPedId()))
end)

exports('isdead',function()
    return morto
end)

if SM.EnableDebugCommand then
RegisterCommand("die",function()
    SetEntityHealth(PlayerPedId(), 0)
end)
end
