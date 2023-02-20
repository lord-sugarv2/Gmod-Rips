local Categories = {
    [1] = {
        ChatMessage = {Color(246, 87, 87), "[ Normal RIP ] ", Color(255, 255, 255), "%attacker ripped %players's %gun"},
        DiscordMessage = {"**Normal RIP**", "Attacker: %attacker\n Loser: %players's\n Weapon Lost: %gun"},
    },
    [2] = {
        ChatMessage = {Color(236, 179, 57), "[ Special RIPs ] ", Color(255, 255, 255), "%attacker ripped %players's %gun"},
        DiscordMessage = {"**Special RIP**", "Attacker: %attacker\n Loser: %players's\n Weapon Lost: %gun"},
    },
}

local Weapons = {
--  ["weapon_class"] = {"Nice Name", categoryType},
    ["stunstick"] = {"Stun Stick", 1},
    ["weapon_hpwr_stick"] = {"Wand", 2}
}

local function formatChatText(textData, attackerName, playerName, gunName)
    local tbl = {}
    for k, v in ipairs(textData) do
        if not isstring(v) then table.insert(tbl, v) continue end
        v = string.Replace(v, "%attacker", attackerName)
        v = string.Replace(v, "%players", playerName)
        v = string.Replace(v, "%gun", gunName)
        table.insert(tbl, v)
    end
    return tbl
end

local function formatDiscordText(textData, attackerName, playerName, gunName)
    textData = string.Replace(textData, "%attacker", attackerName)
    textData = string.Replace(textData, "%players", playerName)
    textData = string.Replace(textData, "%gun", gunName)
    return textData
end

util.AddNetworkString("Lords:RIPMessage")
hook.Add("DoPlayerDeath", "Lords:RIPDamage", function(deadperson, attacker, dmginfo)
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop

    local attackerName = IsValid(attacker) and attacker:IsPlayer() and attacker:Nick() or "N/A" 
    for k, v in ipairs(deadperson:GetWeapons()) do
        local class = v:GetClass()
        if not Weapons[class] then continue end

        net.Start("Lords:RIPMessage")
        net.WriteTable(formatChatText(Categories[Weapons[class][2]].ChatMessage, attackerName, deadperson:Nick(), Weapons[class][1]))
        net.Broadcast()
        DiscordMessage(Categories[Weapons[class][2]].DiscordMessage[1], formatDiscordText(Categories[Weapons[class][2]].DiscordMessage[2], attackerName, deadperson:Nick(), Weapons[class][1]))
    end
end)