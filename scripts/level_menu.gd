extends Node2D

@onready var LevelOne = $CanvasLayer/Level1
@onready var LevelTwo = $CanvasLayer/Level2
@onready var LevelThree = $CanvasLayer/Level3



func _ready():
	LevelOne.ThisLevelNumber = 1
	LevelTwo.ThisLevelNumber = 2
	LevelThree.ThisLevelNumber = 3
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui_scenes/main_menu.tscn")
