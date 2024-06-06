# meta-name: 效果
# meta-description: 创建可应用于目标的效果
class_name MyAwesomeEffect
extends Effect

var member_var := 0

func execute(targets: Array[Node]) -> void:
	print("效果目标: %s" % targets)
	print("做什么事情: %s" % member_var)
