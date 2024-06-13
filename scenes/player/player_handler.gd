class_name PlayerHandler
extends Node

#抽牌/弃牌时间间隔，视觉效果更好
const HAND_DRAW_INTERVAL := 0.2
const HAND_DISCARD_INTERVAL := 0.2

@export var hand: Hand
 
var character: CharacterStats

func _ready() -> void:
	Events.card_playerd.connect(_on_card_played)

func start_battle(char_stats: CharacterStats) -> void:
	character = char_stats
	character.draw_pile = character.deck.duplicate(true)
	character.draw_pile.shuffle()
	character.discard = CardPile.new()
	start_turn()
	
func start_turn() -> void:
	character.block = 0
	character.reset_mana()
	draw_cards(character.cards_per_trun)
	
func end_turn() -> void:
	hand.disable_hand()
	discard_cards()


func draw_card() -> void:
	reshuffle_deck_from_discard()
	hand.add_card(character.draw_pile.draw_card())
	reshuffle_deck_from_discard()
	
func draw_cards(amount: int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
		
	tween.finished.connect(
		func(): Events.player_hand_drawn.emit()
	)

func discard_cards() -> void:
	if hand.get_child_count() == 0:
		Events.player_hand_discarded.emit()
		return
	
	var tween := create_tween()
	for card_ui: CardUI in hand.get_children():
		#将当前牌添加到弃牌堆
		tween.tween_callback(character.discard.add_card.bind(card_ui.card))
		#调用hands.discard_card函数
		tween.tween_callback(hand.discard_card.bind(card_ui))
		#等待hand_discard_interval秒，然后丢弃下一张牌
		tween.tween_interval(HAND_DISCARD_INTERVAL)
	
	#接下来敌人的回合会从这里开始
	tween.finished.connect(
		func(): Events.player_hand_discarded.emit()
	)

#通过丢弃功能重新洗牌
func reshuffle_deck_from_discard() -> void:
	#首先检查抽牌堆是否为空
	if not character.draw_pile.empty():
		return
	
	#从弃牌堆取出最上面的牌添加到抽牌堆，直到弃牌堆空
	while not character.discard.empty():
		character.draw_pile.add_card(character.discard.draw_card())

	character.draw_pile.shuffle()

func _on_card_played(card: Card) -> void:
	character.discard.add_card(card)

