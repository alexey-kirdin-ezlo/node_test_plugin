local _core = require("core")
local _logger = require("logging")

local params = ... or {}
local items = {}

if type(params.item_id) == "string" then
    -- single item and single value case
    items = { [params.item_id] = { value = params.value } }

elseif type(params.item_ids) == "table" then
    -- multi-item and single value case
    for _, item_id in ipairs(params.item_ids) do
        items[item_id] = { value = params.value }
    end

elseif type(params.items) == "table" then
    -- multi-item and multi-value case
    items = params.items
end


for item_id, item_value in pairs(items) do
    local item = _core.get_item(item_id)
    local item_script = loadfile("HUB:node_test_plugin/scripts/items/" .. item.name)

    if item_script then
        local success, errmsg = pcall(item_script, {
                device_id = item.device_id,
                item_id = item_id,
                value = item_value.value,
                source = params.source
            })
        if not success then
            _logger.error("Failed to set item: " .. item.name .. (errmsg and (", error: " .. errmsg) or ""))
        end
    else
        _logger.error("Failed to load handler for item: " .. item.name)
    end
end
