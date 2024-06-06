class_name CardPile
extends Resource

#卡堆大小变化时的信号（参数为卡牌数量）
signal card_pile_size_changed(cards_amount)

@export var cards: Array[Card] = []

#检查卡堆是否为空
func empty() -> bool:
	return cards.is_empty()#返回数组是否为空
	
func draw_card() -> Card:
	var card = cards.pop_front()#从数组中弹出前面的值
	#发出卡堆信号并返回从数组中弹出的卡
	card_pile_size_changed.emit(cards.size())
	return card

func add_card(card: Card):
	cards.append(card)
	card_pile_size_changed.emit(cards.size())
	
func shuffle() -> void:
	cards.shuffle()
	
func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())
	
func _to_string() -> String:
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%s: %s" % [i+1, cards[i].id])
	return "\n".join(_card_strings)
	
	
	
	
