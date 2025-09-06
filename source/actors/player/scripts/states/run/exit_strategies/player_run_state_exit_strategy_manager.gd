class_name PlayerRunStateExitStrategyManager
extends RefCounted

var strategies: Array[RefCounted] = [
	PlayerRunStateCrouchExitStrategy,
	PlayerRunStateJumpExitStrategy,
	PlayerRunStateIdleExitStrategy,
	PlayerRunStateWalkExitStrategy,
]


func get_strategy(owner: PlayerRunState) -> PlayerRunStateBaseExitStrategy:
	for strategy: RefCounted in strategies:
		var strategy_instance: PlayerRunStateBaseExitStrategy = strategy.new(owner)
		if strategy_instance.can_handle():
			return strategy_instance
	return null
