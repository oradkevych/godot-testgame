extends Area2D
signal egg_on_floor

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.is_in_group("Objects"):
		body.delete()
		if body.is_in_group("Eggs"):
			egg_on_floor.emit()
