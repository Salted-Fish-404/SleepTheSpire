extends Card

var timer: Timer

func apply_effects(targets: Array[Node]) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 5
	damage_effect.sound = sound
	for i in range(2):
		damage_effect.execute(targets)
	
	
