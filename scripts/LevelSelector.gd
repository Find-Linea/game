extends Area2D

@onready var LevelNumber : Label = $LevelNumber
@onready var LevelLock : Sprite2D = $LevelLock

var ThisLevelNumber : int
var Clickable : bool

var levelOne : String = "res://scenes/levels/level_1.tscn"
var levelTwo : String = "res://scenes/levels/level_3.tscn"
var levelThree : String = "res://scenes/levels/level_4.tscn"

func _ready():
	LevelLock.visible = true
	LevelNumber.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	RemoveLock()
	DetectClickAndChangeLevel()


func RemoveLock() -> void:
	if ThisLevelNumber <= GlobalScript.LastUnlockedLevel and LevelLock.visible == true:
		LevelLock.visible = false
		LevelNumber.visible = true
		LevelNumber.text = str(ThisLevelNumber)
	
func DetectClickAndChangeLevel() -> void:
	if Input.is_action_pressed("frog_click") and Clickable and not LevelLock.visible :
		if ThisLevelNumber == 1 : 
			get_tree().change_scene_to_file(levelOne)
		if ThisLevelNumber == 2 :
			get_tree().change_scene_to_file(levelTwo)
		if ThisLevelNumber == 3 :
			get_tree().change_scene_to_file(levelThree)
			

func _on_mouse_entered() -> void:
	Clickable = true

func _on_mouse_exited() -> void:
	Clickable = false
