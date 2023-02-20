net.Receive("Lords:RIPMessage", function()
    local message = net.ReadTable()
    chat.AddText(unpack(message))
end)