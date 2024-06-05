local maxbutt1log = get("maxbutt1log")
local maxtest = get("maxtest")

local username
local password

maxbutt1log.on_click(function()

    username = get("usernameinput")
    password = get("passwordinput")

    maxtest.set_contents(username.." "..password)
    
end)
