extends Card

@export var optional_sound: AudioStream

func apply_effects(targets: Array[Node]) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 10
	damage_effect.sound = sound
	damage_effect.execute(targets)
	print("你对这名敌人施加了2点易伤")

