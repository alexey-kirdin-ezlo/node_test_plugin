local _logger = require("logging")

_logger.info("node_test_plugin starting up...")

loadfile("HUB:node_test_plugin/scripts/functions/create_device")()
