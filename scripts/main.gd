extends Node
var score = 0
@export var egg_scene: PackedScene
@export var bird_scene: PackedScene
@export var powerBone_scene: PackedScene
var difficulty = 1
var boneTimer = 6
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$HUD.show_game_start()
	$BoneTimer.wait_time = boneTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $BoneTimer.is_stopped():
		$HUD.show_bone_timer($BoneTimer.time_left)


func _on_dog_hit_basket(object: String):
	if object == "Egg":
		score += 1
	elif object == "Bone":
		$Dog.increase_dog(0.5)
		start_bone_timer()
	$HUD.update_score(score)
	if score%10 == 0:
		spawn_bird()
	
func start_bone_timer():
	var delta = 0
	if $BoneTimer.is_stopped():
		pass
	else:
		delta = $BoneTimer.time_left
		$BoneTimer.wait_time = delta + boneTimer
	$BoneTimer.start()
	
func _on_bone_timer_timeout():
	$Dog.reset_size_dog()
	$HUD.hide_bone_timer()
	
func _on_floor_egg_on_floor():
	game_over()
	pass

func game_over():
	$ObjTimer.stop()
	$HUD.show_game_over()
	var objects = get_tree().get_nodes_in_group("Objects")
	for object in objects:
		object.delete()
	score = 0
	$HUD.update_score(score)
	$Dog.end_game()
	
func new_game():
	randomize()
	score = 0
	$HUD.show_game()
	$Dog.start($DogStartPosition.position)
	$ObjTimer.start()

func _on_obj_timer_timeout():
	spawn_obj()
	$ObjTimer.wait_time = randf_range(1,3.5)
	
func spawn_obj():
	var obj = null
	var objectNum = randi_range(1,100)
	if objectNum < 85:
		obj = egg_scene.instantiate()
	else:
		obj = powerBone_scene.instantiate()		
	var obj_spawn_location = get_node("ObjSpawner/ObjSpawnLocation")
	obj_spawn_location.progress_ratio = randf()
	obj.position = obj_spawn_location.position
	obj.gravity_scale = randf_range(0.001,0.1)
	add_child(obj)

func spawn_bird():
	var bird = bird_scene.instantiate()
	bird.speed = 100
	var path = randi_range(1,6)
	if path%2 == 0:
		bird.flip = "left"
	else:
		bird.flip == "right"
	var parent_path = get_node("BirdPath"+str(path)+"/BirdFollowPath")
	parent_path.add_child(bird)

func _on_hud_start():
	new_game()

	
