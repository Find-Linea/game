extends Node2D


var levelOne ="res://scenes/levels/level_1.tscn"
var levelTwo = "res://scenes/levels/level_3.tscn"
var levelThree = "res://scenes/levels/level_4.tscn"
var levelMenu = "res://scenes/ui_scenes/level_menu.tscn"


func _ready():
	GlobalScript.CurrentLevel = null
	GlobalScript.musicPlaying = false
	AudioPlayer.play_mainmenu_music()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_play_button_pressed():
	if GlobalScript.LastUnlockedLevel == 0:
		get_tree().change_scene_to_file(levelOne)
	elif GlobalScript.LastUnlockedLevel == 1:
		get_tree().change_scene_to_file(levelTwo)
	elif GlobalScript.LastUnlockedLevel == 2:
		get_tree().change_scene_to_file(levelThree)
	else:
		get_tree().change_scene_to_file(levelOne)
		

func _on_levels_button_pressed():
	get_tree().change_scene_to_file(levelMenu)
	


func _on_quit_pressed():
	get_tree().quit()


func _on_spin_wheel_button_pressed():
	get_tree().change_scene_to_file("res://scenes/spinning_wheel_scene.tscn")


func _on_e_frogs_pressed():
	get_tree().change_scene_to_file("res://scenes/ui_scenes/nftmenu.tscn")


func _on_t_croak_faucet_pressed():
	JavaScriptBridge.eval("window.faucet()")
