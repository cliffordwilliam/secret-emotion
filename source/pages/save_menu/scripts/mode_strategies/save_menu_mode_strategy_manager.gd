class_name SaveMenuModeStrategyManager
extends RefCounted
# TODO: Delete this, we want 2 seperated page, save and load
# TODO: But is that redundant? Yeah but at least its flexible and UI is messy in nature anyways

var strategies: Array[RefCounted] = [
	SaveMenuSaveModeStrategy,
	SaveMenuLoadModeStrategy,
]


func get_strategy(owner: SaveMenu) -> SaveMenuBaseModeStrategy:
	for strategy: RefCounted in strategies:
		var strategy_instance: SaveMenuBaseModeStrategy = strategy.new(owner)
		if strategy_instance.can_handle(owner.action):
			return strategy_instance
	push_error("No strategy found for action %s" % owner.action)
	return null
