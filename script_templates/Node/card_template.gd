# meta-name: 卡牌逻辑
# meta-description: 卡牌打出时有什么效果
extends Card

@export var optional_sound: AudioStream

func apply_effects(targets: Array[Node]) -> void:
	print("好耶")
	print("目标: %s" % targets)
