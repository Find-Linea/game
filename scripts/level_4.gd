extends Node2D

@onready var Frogs = $Frogs
@onready var FrogCounter = $CanvasLayer/FrogCounter/FrogCount
@onready var PopUpMenu = $CanvasLayer/PopUP
@onready var SpecialFrog = $NFTFrog/SpecialFrog
@onready var PauseMenu = $CanvasLayer/PauseMenu

var specialFrogCaught = false
var levelCompleted = false
var MaximumFrogs = 0
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	PauseMenu.visible = false
	PopUpMenu.visible = false
	GlobalScript.CurrentLevel = 3
	MaximumFrogs = Frogs.get_child_count() # Set MaximumFrogs to the total number of frog nodes
	FrogCounterUpdate()

# Called every frame
func _process(delta):
	FrogCounterUpdate()
	NFT_FrogCaught()

func FrogCounterUpdate():
	count = 0
	for frog in Frogs.get_children():
		if not frog.visible: # Count the frogs that are not visible (caught)
			count += 1
	FrogCounter.text = str(count) + "/" + str(MaximumFrogs)
	if count == MaximumFrogs:
		if not levelCompleted:
			levelCompleted = true
			GlobalScript.PlayersCroak += 20
			PopUpMenu.visible = true
			PopUpMenu.TitlePass("Level Completed")
			PopUpMenu.TextPass("Congratulations! You have completed the level and earned 20 Croaks. Use them wisely in your next adventures!")
		if PopUpMenu.visible == false:
			GlobalScript.handleCompletion(3)
			get_tree().change_scene_to_file("res://scenes/ui_scenes/main_menu.tscn")


func NFT_FrogCaught():
	if SpecialFrog.visible == false and not specialFrogCaught:
		await get_tree().process_frame
		specialFrogCaught = true
		PopUpMenu.visible = true
		var NftName = SpecialFrog.nftName
		if NftName:
			PopUpMenu.TitlePass("NFT Won!")
			PopUpMenu.TextPass("Congratulations! You have won a free NFT. It will be generated and added to your collection shortly.")
		else:
			PopUpMenu.TitlePass("Already Collected!")
			PopUpMenu.TextPass("Congratulations! You already have this free NFTs. Visit Ethereum Frogs to get more.")
				
