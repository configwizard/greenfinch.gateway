local http = require "resty.http"
local httpc = http.new()

httpc:set_timeout(3000) -- 3 seconds timeout

local res, err = httpc:request_uri("https://jsonplaceholder.typicode.com/todos/1", {
    method = "GET",
    ssl_verify = false
    -- ssl_verify = true,
    -- ssl_ca_cert = "/path/to/ca-bundle.crt"
})

if not res then
    ngx.status = ngx.HTTP_INTERNAL_SERVER_ERROR
    ngx.say("Failed to fetch JSON data: ", err)
    return
end

ngx.say(res.body)