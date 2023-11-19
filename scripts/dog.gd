extends Area2D

signal hit_basket(object)
@export var speed = 200
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$DogSprite.animation = "idle"
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$DogSprite.play()
	move_dog(delta)

func move_dog(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed	
	if velocity.x == 0:
		$DogSprite.animation = "idle"
	else:
		$DogSprite.animation = "walk"
		if velocity.x > 0:
			if not dog_facing_right():
				scale.x *= -1
			#$DogSprite.flip_h = false
		else:
			if dog_facing_right():
				scale.x *= -1
			#$DogSprite.flip_h = true
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func dog_facing_right():
	if scale.x > 0:
		return true
	return false
	
func increase_dog(size: float):
	if abs(scale.x) >= 3:
		return
	if dog_facing_right():
		scale.x += size
	else:
		scale.x -= size
		
func reset_size_dog():
	if dog_facing_right():
		scale.x = 1
	else:
		scale.x = -1	
		
func start(pos):
	position = pos
	show()
	
func end_game():
	hide()

func _on_body_entered(body):
	if body.is_in_group("Objects"):
		body.delete()
	if body.is_in_group("Eggs"):
		hit_basket.emit("Egg")
	elif body.is_in_group("Power"):
		if body.is_in_group("Bone"):
			hit_basket.emit("Bone")
