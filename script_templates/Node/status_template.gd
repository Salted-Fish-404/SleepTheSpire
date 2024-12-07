# meta-name: 状态
# meta-description: 创建可应用于目标的状态
class_name MyAwesomeStatus
extends Status

var mamber_var := 0

#初始化状态,例如添加状态时调用
func initialize_status(target: Node) -> void:
	print("初始化 %s 的状态" % target)

#应用状态，例如状态生效时调用
func apply_status(target: Node) -> void:
	print("我的状态目标：%s" % target)
	print("效果：%s" % mamber_var)
	
	status_applied.emit(self)
