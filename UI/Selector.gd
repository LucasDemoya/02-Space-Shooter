extends Control


func _ready():
	pass


func _on_Ship1_pressed():
	Global.Player = load("res://Player/Ship1.tscn")
	var _scene = get_tree().change_scene("res://Game.tscn")


func _on_Ship2_pressed():
	Global.Player = load("res://Player/Ship2.tscn")
	var _scene = get_tree().change_scene("res://Game.tscn")


func _on_Ship3_pressed():
	Global.Player = load("res://Player/Ship3.tscn")
	var _scene = get_tree().change_scene("res://Game.tscn")
