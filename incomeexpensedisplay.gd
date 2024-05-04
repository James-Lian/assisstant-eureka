extends HBoxContainer

signal removed(identifier)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_delete_pressed():
	removed.emit(get_node("Label").text)
	queue_free()
