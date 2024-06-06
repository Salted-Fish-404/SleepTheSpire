extends EnemyAction

@export var damage := 7

func perform_action() -> void:
	if not enemy or not target:
		return
		
	#补间动画，用于将敌人调整到玩家为止并返回
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	#起始位置
	var start := enemy.global_position
	#结束位置（玩家右侧32像素）
	var end := target.global_position + Vector2.RIGHT * 32
	#伤害效果
	var damage_effect := DamageEffect.new()
	#目标数组（只包含目标节点）
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	damage_effect.sound = sound
	
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	
	tween.finished.connect(
		func(): Events.enemy_action_completed.emit(enemy)
	)
