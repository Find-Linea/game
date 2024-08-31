extends Node2D

@onready var TouchResponsive = $ColorRect



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ManagePause()
	if self.visible == true:
		TouchResponsive.MOUSE_FILTER_STOP
	else:
		TouchResponsive.MOUSE_FILTER_IGNORE




func ManagePause():
	if Input.is_action_just_pressed("Quit") and get_tree().paused == false:
		self.visible = true 
		get_tree().paused = true
	elif Input.is_action_just_pressed("Quit") and get_tree().paused == true:
		self.visible = false 
		get_tree().paused = false
		


func _on_resume_button_pressed():
	self.visible = false 
	get_tree().paused = false


func _on_main_menu_pressed():
	self.visible = false 
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui_scenes/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
