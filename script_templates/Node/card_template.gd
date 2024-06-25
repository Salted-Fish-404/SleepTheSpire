# meta-name: 卡牌逻辑
# meta-description: 卡牌打出时有什么效果
extends Card

@export var optional_sound: AudioStream

func get_default_tooltip() -> String:
	return tooltip_text
	
func get_updated_tooltip(_player_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	return tooltip_text

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	print("好耶")
	print("目标: %s" % targets)
