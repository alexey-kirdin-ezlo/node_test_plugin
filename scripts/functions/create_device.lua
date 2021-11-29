local _core = require("core")
local _logger = require("logging")
local _storage = require("storage")
local _constants = require("HUB:node_test_plugin/configs/constants")

--------------------------------------------------------------------
local credentials = _storage.get_table(_constants.STORAGE_ACCOUNT_KEY)

if not credentials then
    _logger.warning("No accout is configured. Cannot create devices...")
    return
end
--------------------------------------------------------------------


local function CreateDevice ()
    local my_gateway_id = (_core.get_gateway() or {}).id
    if not my_gateway_id then
        _logger.error("Failed to get current gateway ID, skip creating devices")
        return nil
    end

    for _, device in pairs(_core.get_devices() or {}) do
        if device.gateway_id == my_gateway_id then
            return device.id
        end
    end

    _logger.info("Create new fake device")
    return _core.add_device {
        type = "switch.inwall",
        device_type_id = "switch.inwall.fake",
        category = "switch",
        subcategory = "interior_plugin",
        battery_powered = false,
        gateway_id = _core.get_gateway().id,
        name = "Fake InWall Switch",
        info = {
            manufacturer = "Ezlo",
            model = "1.0"
        }
    }
end

local function CreateItem (device_id)
    if not device_id then
        _logger.error("Cannot create item. Missing device_id...")
        return
    end

    for _, item in ipairs(_core.get_items_by_device_id(device_id) or {}) do
        return
    end

    _logger.info("Create new fake 'switch' item")
    _core.add_item({
        device_id = device_id,
        name = "switch",
        value_type = "bool",
        value = false,
        has_getter = true,
        has_setter = true
    })
end

--------------------------------------------------------------------

local args = ... or {}

local device_id = CreateDevice()
CreateItem(device_id)
