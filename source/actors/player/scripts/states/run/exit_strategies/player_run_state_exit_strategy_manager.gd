class_name PlayerRunStateExitStrategyManager
extends RefCounted

var strategies: Array[RefCounted] = [
	PlayerRunStateCrouchExitStrategy,
	PlayerRunStateJumpExitStrategy,
	PlayerRunStateIdleExitStrategy,
	PlayerRunStateWalkExitStrategy,
]


func get_strategy(owner: PlayerRunState) -> PlayerRunStateBaseExitStrategy:
	for strat_class in strategies:
		var strat: PlayerRunStateBaseExitStrategy = strat_class.new(owner)
		if strat.can_handle():
			return strat
	return null
