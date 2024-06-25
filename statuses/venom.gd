class_name VenomStatus
extends Status

const MODIFIER := 0.5

func get_tooltip() -> String:
	return tooltip % duration

#应用状态，例如状态生效时调用
func apply_status(target: Node) -> void:
	
	var damage_effect := DamageEffect.new()
	damage_effect.amount = duration #暂时的,以后调整成层数相关
	damage_effect.execute([target])
	
	status_applied.emit(self)
