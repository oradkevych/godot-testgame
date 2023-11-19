extends RigidBody2D
@export var path: PathFollow2D
@export var speed: int = 100
@export var flip: String = "right"
var inc=0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	if flip == "right":
		scale.x = 1
		scale.y = 1
	elif flip == "left":
		scale.x = 1
		scale.y = -1
	$BirdAnimation.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)

func destroy():
	queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	destroy()
