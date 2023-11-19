extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$EggSprite.animation = str(randi_range(1,5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func delete():
	queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	delete()






