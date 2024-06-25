class_name Status
extends Resource

signal status_applied(status: Status) #状态已应用
signal status_changed #状态已更改

enum Type {START_OF_TURN, END_OF_TURN, EVENT_BASED} #回合开始，回合结束，依赖某些事件
enum StackType {NONE, INTENSITY, DURATION} #buff类型，不可堆叠，基于强度的堆叠，基于持续时间的堆叠

@export_group("Status Data") #状态数据导出组
@export var id: String
@export var type: Type
@export var stack_type: StackType
@export var can_expire: bool #是否有持续时间
@export var duration: int : set = set_duration #持续时间
@export var stacks: int : set = set_stacks #堆栈

@export_group("Status Visuals") #状态视觉效果导出组
@export var icon: Texture
@export_multiline var tooltip: String

#初始化状态,例如添加状态时调用
func initialize_status(_target: Node) -> void:
	pass

#应用状态，例如状态生效时调用
func apply_status(_target: Node) -> void:
	status_applied.emit(self)


func get_tooltip() -> String:
	return tooltip
	
#设置持续时间
func set_duration(new_duration: int) -> void:
	duration = new_duration
	status_changed.emit()
	
func set_stacks(new_stacks: int) -> void:
	stacks = new_stacks
	status_changed.emit()

