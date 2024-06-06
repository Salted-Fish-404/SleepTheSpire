class_name EnemyAction
extends Node

#两种行动模式：有条件的行动和基于概率的行动
enum Type {CONDITIONAL, CHANCE_BASED}

@export var intent: Intent #意图
@export var sound: AudioStream
@export var type: Type #类型
@export_range(0.0, 10.0) var chance_weight := 0.0 #权重

@onready var accumulated_weight := 0.0 #累计权重

var enemy: Enemy #敌人
var target: Node2D #针对目标

func is_performable() -> bool:
	return false
	
func perform_action() -> void:
	pass
