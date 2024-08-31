extends Node2D

@onready var eFrog1 = $eFrogs/eFrog1
@onready var eFrog2 = $eFrogs/eFrog2
@onready var eFrog3 = $eFrogs/eFrog3
@onready var eFrog4 = $eFrogs/eFrog4
@onready var eFrog5 = $eFrogs/eFrog5
@onready var eFrog6 = $eFrogs/eFrog6

@onready var Lock1 = $Locks/LevelLock
@onready var Lock2 = $Locks/LevelLock2
@onready var Lock3 = $Locks/LevelLock3
@onready var Lock4 = $Locks/LevelLock4
@onready var Lock5 = $Locks/LevelLock5
@onready var Lock6 = $Locks/LevelLock6

func _ready():
	handleAnimations()

func _process(delta):
	pass

func handleAnimations():
	var frog_animations = [
		eFrog1,
		eFrog2,
		eFrog3,
		eFrog4,
		eFrog5,
		eFrog6
	]

	var locks = [
		Lock1,
		Lock2,
		Lock3,
		Lock4,
		Lock5,
		Lock6
	]

	var nfts_count = GlobalScript.nfts_generated.size()

	for i in range(6):
		# Check if both the frog and lock nodes exist
		if frog_animations[i] != null and locks[i] != null:
			if i < nfts_count:
				locks[i].visible = false
				frog_animations[i].visible = true
				frog_animations[i].play(GlobalScript.nfts_generated[i])
			else:
				locks[i].visible = true
				frog_animations[i].visible = false
		else:
			print("Error: One of the nodes (Frog or Lock) is not properly assigned.")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui_scenes/main_menu.tscn")
