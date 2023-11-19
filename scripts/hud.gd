extends CanvasLayer
signal start

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.visible = false
	$Button.visible = false
	$Label.visible = false
	$EndScore.visible = false
	$BoneSprite.visible = false
	$LabelBoneTime.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func update_score(score):
	$Score.text = str(score)

func show_bone_timer(time: float):
	$BoneSprite.visible = true
	$LabelBoneTime.visible = true
	$LabelBoneTime.text = str(int(time))
	
func hide_bone_timer():
	$BoneSprite.visible = false
	$LabelBoneTime.visible = false
	
func show_game():
	$Score.visible = true
	$Button.visible = false
	$Label.visible = false
	$EndScore.visible = false
	
func show_game_start():
	$Score.visible = false
	$Button.visible = true
	$Label.visible = true
	$EndScore.visible = false
	
func show_game_over():
	$Score.visible = false
	$Button.visible = true
	$Label.text = "Game Over"
	$EndScore.text = "Score: "+$Score.text
	$EndScore.visible = true
	$Label.visible = true


func _on_button_pressed():
	start.emit()
