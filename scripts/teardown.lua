local _core = require("core")
local _storage = require("storage")
local _logger = require("logging")

_logger.info("node_test_plugin teardown...")

_logger.info("Cleanup storage...")
_storage.delete_all()

_logger.info("Cleanup devices...")
_core.remove_gateway_devices(_core.get_gateway().id)
