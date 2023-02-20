local webhook = "https://discord.com/api/webhooks/1077269210318786670/G9Rz082UP_pJQZutP7_1PX1svkb8kxpcYfROGKjL8rS2lBKfHH-jt5gbTwEHS1dLNfb4"

if pcall(require, "reqwest") and reqwest ~= nil then
    my_http = reqwest
else
    my_http = HTTP
end
require("reqwest")

function DiscordMessage(title, message, col)
    reqwest({
        method = "POST",
        url = webhook,
        timeout = 30,

        body = util.TableToJSON({
            avatar_url = "https://imgur.com/xudxIXD.png",
            username = "RIP Bot",
            content = "",
            embeds = {
                {
                    title = title,
                    description = message,
                    color = col or 15158332,
                },
            },
        }),
        type = "application/json",

        headers = {
            ["User-Agent"] = "My User Agent",
        },

        success = function(status, body, headers) end,
        failed = function(err, errExt) 
            print(err, errExt)
        end
    })
end