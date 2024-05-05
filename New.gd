extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_budget_pressed():
	get_tree().change_scene_to_file("res://budget.tscn")

func _on_grades_pressed():
	get_tree().change_scene_to_file("res://node_2d.tscn")

func _on_todo_pressed():
	get_tree().change_scene_to_file("res://TODOLIST.tscn")
