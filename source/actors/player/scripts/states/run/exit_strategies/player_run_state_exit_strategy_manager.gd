class_name PlayerRunStateExitStrategyManager
extends RefCounted
# Holds all run state exit strategies (before move and slide)
# Each strategies are extension of the owner

var owner: PlayerRunState
var strategies: Array[RefCounted] = []


func _init(given_owner: PlayerRunState) -> void:
	owner = given_owner
	strategies = [
		PlayerRunStateCrouchExitStrategy.new(owner),
		PlayerRunStateJumpExitStrategy.new(owner),
		PlayerRunStateIdleExitStrategy.new(owner),
		PlayerRunStateWalkExitStrategy.new(owner),
	]


func get_strategy() -> PlayerRunStateBaseExitStrategy:
	for strategy: RefCounted in strategies:
		if strategy.can_handle():
			return strategy
	return null
