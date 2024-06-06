extends Node

#Card相关信号
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_playerd(card: Card)
signal card_tooltip_requested(card: Card)
signal tooltip_hide_requested

#Player相关信号
signal player_hand_drawn
signal player_hand_discarded #弃牌
signal player_turn_ended #结束回合
signal player_hit
signal player_died

#敌人相关信号
signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended

#屏幕场景相关信号
signal battle_over_screen_requested(test: String, type: BattleOverPanel.Type)



