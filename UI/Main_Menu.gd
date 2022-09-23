extends Control


func _ready():
	pass


func _on_Play_pressed():
	var _signal = get_tree().change_scene("res://UI/Selector.tscn")
