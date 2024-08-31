extends Node2D

@onready var TouchResponsive = $ColorRect
@onready var Info = $Info
@onready var Title = $Title


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ManagePause()
	if self.visible == true:
		TouchResponsive.MOUSE_FILTER_STOP
	else:
		TouchResponsive.MOUSE_FILTER_IGNORE


func _on_continue_button_pressed():
	self.visible = false
	TouchResponsive.MOUSE_FILTER_IGNORE
	
func TextPass(text):
	Info.text = text
	
func TitlePass(title):
	Title.text = title

func ManagePause():
	if get_tree().paused == true:
		TouchResponsive.MOUSE_FILTER_IGNORE
	else:
		TouchResponsive.MOUSE_FILTER_STOP
		
