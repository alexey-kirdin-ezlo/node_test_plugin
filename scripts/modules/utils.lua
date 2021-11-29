local _M = {}


function _M.URL_Encode (url)
    url = url:gsub("%W", function (c)
                            return string.format("%%%02X", string.byte(c))
                         end)
    return url
end


function _M.RandomHexString (len)
    local rs = ""
    for _ = 1, len do
        rs = rs .. string.format("%02x", math.random(32, 126))
    end
    return rs
end


return _M
