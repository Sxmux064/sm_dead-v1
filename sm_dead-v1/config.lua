SM = {}

SM.ReviveCommand_Label = 'rianima' -- configurable /command to revive player ("staff member")
SM.HealCommand_Label = 'cura' -- configurable /command to heal player ("staff member")
SM.Admin = 'mod' -- Second group to be enable to revive a player.
SM.KeyToRespawn = 'E' -- Key to respawn after seconds
SM.ItemToRevive = { -- max 1 item
    {itemname = 'medikit', quantity = 1}
}
SM.UseSaltyChat = false -- Use SaltyChat?
SM.SecondToRespawn = 30 -- seconds
SM.Coord_Respawn = vec4(297.4962, -582.9484, 43.1325, 32.4987)

--

SM.animDict = 'dead'
SM.animName = 'dead_a'
SM.ReloadDeathAnimTime = 2000

--

SM.EnableDebugCommand = true -- enable command /die?
SM.Languages = {
    ['predeath_prog_label'] = 'Stai per morire dissanguato.',
    ['haven\'t_medikit'] = 'Non hai abbastanza ', -- left space for item name pls.
    ['respwan_avviable'] = 'RESPAWN DISPONIBILE IN ', -- text time to respawn
    ['click_to_respawn'] = 'PREMI [~b~E~s~] PER TORNARE IN OSPEDALE',
    ['you\'re_not_dead'] = 'Non sei morto! Se vuoi curarti usa il comando /'
}

-- Created by ł S#0440 with ❤ (don't leak this script STRONZI!).

-- In this script I have created an export, which will be used by you to block yours to the people when he is dead. an example: 

--[[
    
RegisterCommand("command",function()
    local dead = exports["nameofthisresource"]:isdead()
    if dead then return end
    print("Im not dead!")
end)

--]]