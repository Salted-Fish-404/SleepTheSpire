class_name MuscleStatus
extends Status

func get_tooltip() -> String:
	return tooltip % stacks

# 初始化状态,例如添加状态时调用
func initialize_status(target: Node) -> void:
	status_changed.connect(_on_status_changed.bind(target))
	_on_status_changed(target)

# 当状态改变时调用
func _on_status_changed(target: Node) -> void:
	# 断言target对象有modifier_handler属性，否则报错
	assert(target.get("modifier_handler"), "%s 无修正值" % target)
	
	# 从modifier_handler获取伤害修正值
	var dmg_dealt_modifier: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_DEALT)
	# 断言dmg_dealt_modifier存在，否则报错
	assert(dmg_dealt_modifier, "%s 无伤害修正" % target)
	
	# 获取muscle的修饰值
	var muscle_modifier_value := dmg_dealt_modifier.get_value("muscle")
	
	# 如果muscle_modifier_value不存在，则创建一个新的修饰值
	if not muscle_modifier_value:
		muscle_modifier_value = ModifierValue.create_new_modifier("muscle", ModifierValue.Type.FLAT)
	
	# 设置muscle修饰值的固定数值为stacks
	muscle_modifier_value.flat_value = stacks
	# 将新的修饰值添加到伤害修正器中
	dmg_dealt_modifier.add_new_value(muscle_modifier_value)
	
