extends Card

const VENOM_STATUS = preload("res://statuses/venom.tres")

var venom_duration := 5


func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	var status_effect := StatusEffect.new()
	var venom := VENOM_STATUS.duplicate()
	venom.duration = venom_duration
	status_effect.status = venom
	status_effect.execute(targets)



