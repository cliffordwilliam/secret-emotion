class_name SaveMenuModeStrategyManager
extends RefCounted

var strategies: Array[RefCounted] = [
	SaveMenuSaveModeStrategy,
	SaveMenuLoadModeStrategy,
]


func get_strategy(owner: SaveMenu) -> SaveMenuBaseModeStrategy:
	for strategy in strategies:
		var strategy_instance: SaveMenuBaseModeStrategy = strategy.new(owner)
		if strategy_instance.can_handle(owner.action):
			return strategy_instance
	push_error("No strategy found for action %s" % owner.action)
	return null
