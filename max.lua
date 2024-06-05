local maxbutt1log = get("maxbutt1log")
local maxbutt2sin = get("maxbutt2sin")
local refresh_bal = get("refresh_bal")
local maxtest = get("maxtest")
local bal = get("balance")

local username = get("usernameinput")
local password = get("passwordinput")

local perm_username
local token

maxtest.set_content("1".." ".."12")

maxbutt1log.on_click(function()


    local attempt = login(username.get_content(), password.get_content())
    if (attempt["token"]) then
        maxtest.set_content("Logged in successfully!")
        token = attempt["token"]
        perm_username = username.get_content()
    else 
        maxtest.set_content("Error! Code: " .. attempt.status)
    end

end)

maxbutt2sin.on_click(function()

    local attempt = register(username.get_content(), password.get_content())
    if attempt.status == 201 then
        maxtest.set_content("Account created! Please now log in.")
    else 
        if attempt.status == 400 then
            maxtest.set_content("This username is taken, be quickey m8!")
        else
            maxtest.set_content("Error! Code: " .. attempt.status)
        end

    end

end)

refresh_bal.on_click(function()

    local body = '{"username": "'..perm_username..'"}'

    local res = fetch({
        url = "http://212.227.199.94:19800/maxcoin/check",
        method = "GET",
        headers = { ["Content-Type"] = "application/json" },
        body = body,
    })

    if res["maxcoins"] then
        bal.set_content(res["maxcoins"])
    else
        bal.set_content("Error! Code: " .. res.status)
    end

end)

function login(u, p)
    local body = "{"
    .. '"username": "'
    .. u
    .. '", '
    .. '"password": "'
    .. p
    .. '" }'

    local res = fetch({
        url = "http://212.227.199.94:19800/user/login",
        method = "POST",
        headers = { ["Content-Type"] = "application/json" },
        body = body,
    })
   
    return res
end

function register(u, p)
    local body = "{"
    .. '"username": "'
    .. u
    .. '", '
    .. '"password": "'
    .. p
    .. '" }'

    local res = fetch({
        url = "http://212.227.199.94:19800/user/create",
        method = "POST",
        headers = { ["Content-Type"] = "application/json" },
        body = body,
    })
   
    return res
end
