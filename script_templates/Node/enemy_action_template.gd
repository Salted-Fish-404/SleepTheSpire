# meta-name: 敌人动作
# meta-description: 敌人在其回合时可以执行的动作
extends EnemyAction

func perform_action() -> void:
	if not enemy or not target:
		return
		
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 32
	
	SFXPlayer.play(sound)
	
	Events.enemy_action_completed.emit(enemy)

#如果敌人有动态意图文本，则覆盖基本行为
func update_intent_text() -> void:
	var player := target as Player
	if not player:
		return
		
	var modified_dmg := player.modifier_handler.get_modified_value(6, Modifier.Type.DMG_TAKEN)
	intent.current_text = intent.base_text % modified_dmg
