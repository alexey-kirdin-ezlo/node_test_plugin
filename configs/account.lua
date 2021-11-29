local _storage = require("storage")
local _logger = require("logging")
local _constants = require("HUB:node_test_plugin/configs/constants")

local STORAGE_ACCOUNT_KEY = "account"

-----------------------------------------------------------

local args = ... or {}

local account_credentials = {}

if type(args.username) == "string" and args.username ~= "" then
    account_credentials.username = args.username
end

if type(args.password) == "string" and args.password ~= "" then
    account_credentials.password = args.password
end

-- Simulate a valid login
if account_credentials.username == _constants.DEFAULT_USERNAME and account_credentials.password == _constants.DEFAULT_PASSWORD then
    _logger.info("Logged in successfully...")
    _storage.set_table(STORAGE_ACCOUNT_KEY, account_credentials)

    loadfile("HUB:node_test_plugin/scripts/functions/create_device")()
else
    _logger.warning("The provided credentials are invalid.")
end
