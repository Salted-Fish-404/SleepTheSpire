class_name BattleReward
extends Control

enum  Type {GOLD, NEW_CARD}

const CARD_REWARDS := preload("res://scenes/ui/card_rewards.tscn")
const REWARD_BUTTON := preload("res://scenes/ui/reward_button.tscn")
const GOLD_ICON := preload("res://art/gold.png")
const GOLD_TEXT := "%s 金币"
const CARD_ICON := preload("res://art/rarity.png")
const CARD_TEXT := "添加卡牌"

@export var run_stats: RunStats
@export var character_stats: CharacterStats

@onready var rewards: VBoxContainer = %Rewards

var card_reward_total_weight := 0.0
var card_rarity_weights := {
	Card.Rarity.COMMON: 0.0,
	Card.Rarity.UNCOMMON: 0.0,
	Card.Rarity.RARE: 0.0
}

func _ready() -> void:
	for node: Node in rewards.get_children():
		node.queue_free()
	
func add_card_reward() -> void:
	var card_reward := REWARD_BUTTON.instantiate() as RewardButton
	card_reward.reward_icon = CARD_ICON
	card_reward.reward_text = CARD_TEXT
	card_reward.pressed.connect(_show_card_rewards)
	rewards.add_child.call_deferred(card_reward)
	
func _show_card_rewards() -> void:
	if not run_stats or not character_stats:
		return
		
	var card_rewards := CARD_REWARDS.instantiate() as CardRewards
	add_child(card_rewards)
	card_rewards.card_reward_selected.connect(_on_card_reward_taken)
	
	#算法结束时拥有的三张中最后一张
	var card_reward_array: Array[Card] = []
	#角色可选牌组的副本
	var available_cards: Array[Card] = character_stats.draftable_cards.cards.duplicate(true)
	
	#根据运行统计数据重复当前拥有的卡牌奖励数量
	for i in run_stats.card_rewards:
		#设置出牌机会（每次随机化奖励牌都会改变下一次奖励中卡牌的权重，参考杀戮尖塔wiki）
		_setup_card_chances()
		var roll := randf_range(0.0, card_reward_total_weight)
		
		for rarity: Card.Rarity in card_rarity_weights:
			if card_rarity_weights[rarity] > roll:
				_modify_weights(rarity)#修改权重
				var picked_card := _get_random_available_card(available_cards, rarity)#从对应的稀有度匹配的卡池中抽取卡
				card_reward_array.append(picked_card)#将抽取的卡添加到cardReward数组
				available_cards.erase(picked_card)#然后将其从可用卡中删除（卡牌选择中不会出现相同的卡）
				break
				
	card_rewards.rewards = card_reward_array
	card_rewards.show()

func _setup_card_chances() -> void:
	card_reward_total_weight = run_stats.common_weight + run_stats.uncommon_weight + run_stats.rare_weight
	card_rarity_weights[Card.Rarity.COMMON] = run_stats.common_weight
	card_rarity_weights[Card.Rarity.UNCOMMON] = run_stats.common_weight + run_stats.uncommon_weight
	card_rarity_weights[Card.Rarity.RARE] = card_reward_total_weight
	
func _modify_weights(rarity_rolled: Card.Rarity) -> void:
	if rarity_rolled == Card.Rarity.RARE:
		run_stats.rare_weight = RunStats.BASE_RARE_WEIGHT
	else:
		run_stats.rare_weight = clampf(run_stats.rare_weight + 0.3, run_stats.BASE_RARE_WEIGHT, 5.0)

func _get_random_available_card(available_cards: Array[Card], with_rarity: Card.Rarity) -> Card:
	var all_possible_cards := available_cards.filter(
		func(card: Card):
			return card.rarity == with_rarity
	)
	return all_possible_cards.pick_random()

func _on_card_reward_taken(card: Card) -> void:
	if not character_stats or not card:
		return
		
	character_stats.deck.add_card(card)

#实例化金币奖励按钮
func add_gold_reward(amount: int) -> void:
	var gold_reward := REWARD_BUTTON.instantiate() as RewardButton
	gold_reward.reward_icon = GOLD_ICON
	gold_reward.reward_text = GOLD_TEXT % amount
	gold_reward.pressed.connect(_on_gold_reward_taken.bind(amount))
	rewards.add_child.call_deferred(gold_reward)
	
func _on_gold_reward_taken(amount: int) -> void:
	if not run_stats:
		return
		
	run_stats.gold +=amount

func _on_back_button_pressed() -> void:
	Events.battle_reward_exited.emit()
