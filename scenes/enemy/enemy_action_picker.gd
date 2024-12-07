class_name EnemyActionPicker
extends Node

@export var enemy: Enemy: set = _set_enemy
@export var target: Node2D: set = _set_target

@onready var total_weight := 0.0

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	setup_chances()

#返回敌人动作
func get_action() -> EnemyAction:
	var action := get_first_conditional_action()
	if action:
		return action
		
	return get_chance_based_action()
	
func get_first_conditional_action() -> EnemyAction:
	for action: EnemyAction in get_children():
		if not action or action.type != EnemyAction.Type.CONDITIONAL:
			continue
			
		if action.is_performable():
			return action
	
	return null
	
func get_chance_based_action() -> EnemyAction:
	var roll := randf_range(0.0, total_weight)
	
	for action: EnemyAction in get_children():
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue
			
		if action.accumulated_weight > roll:
			return action
			
	return null

func setup_chances() -> void:
	var action: EnemyAction
	
	for child in get_children():
		action = child as EnemyAction
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue
			
		#将该动作的积累权重更改为总权重
		total_weight += action.chance_weight
		action.accumulated_weight = total_weight
		
func _set_enemy(value: Enemy) -> void:
	#将敌人设置为新值
	enemy = value
	
	#迭代所有动作并将该动作的敌人属性设置为这个新敌人
	for action in get_children():
		action.enemy = enemy
		
func _set_target(value: Node2D) -> void:
	target = value
	
	for action in get_children():
		action.target = target
	
	
	
	
