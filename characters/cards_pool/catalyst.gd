extends Card

const VENOM_STATUS = preload("res://statuses/venom.tres")


func apply_effects(targets: Array[Node], modifiers: ModifierHandler) -> void:
	var status_effect := StatusEffect.new()
	var venom := VENOM_STATUS.duplicate()
	venom.duration = venom.duration * 2
	status_effect.status = venom
	status_effect.execute(targets)

