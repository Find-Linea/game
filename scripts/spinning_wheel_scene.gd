extends Node2D

@onready var SpinningWheel = $SpinningWheelCircleFrame/SpinningWheel
@onready var Ray = $SpinningWheelCircleFrame/Labeller/RayCast2D
@onready var CroakCount = $UIElements/CroakCount
@onready var PopUpMenu = $PopUP
var interact = false
var pat = false


func _ready():
	PopUpMenu.visible = false
	Ray.enabled = false
	CroakCount.text = str(GlobalScript.PlayersCroak)

func _process(delta):
	handlePatOnHead()
	if not SpinningWheel.spinning and interact: 
		$SpinMech/Crank.play("Normal")
		Ray.enabled = true
		await get_tree().process_frame  # Wait for the next frame
		if Ray.is_colliding():
			interact = false
			handleReward(Ray.get_collider().name)
		Ray.enabled = false

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui_scenes/main_menu.tscn")

func updateCroakCount():
	CroakCount.text = str(GlobalScript.PlayersCroak)
	
func _on_frog_head_mouse_entered():
	pat = true

func _on_frog_head_mouse_exited():
	pat = false

func handlePatOnHead():
	if pat == true and Input.is_action_just_pressed("frog_click") and SpinningWheel.spinning == false:
		if GlobalScript.PlayersCroak >= 20:
			GlobalScript.PlayersCroak -= 20
			updateCroakCount()
			handleFrogPart()
			JavaScriptBridge.eval("window.spin()")
			
		

func handleFrogPart():
	$SpinMech/Frog.play("PurpleFrogAttack")
	var timer = Timer.new()
	add_child(timer)
	timer.start(0.75)
	await timer.timeout
	$SpinMech/Crank.play("Spin")
	SpinningWheel.spin_velocity = randf_range(100, 300)
	SpinningWheel.spinning = true
	interact = true
	timer.start(0.48)
	await timer.timeout
	$SpinMech/Frog.play("PurpleFrogIdle")
		
func handleReward(reward):
	match reward:
		"FreeNFT":
			var NftName = GlobalScript.GenerateRandomNFT()
			PopUpMenu.visible = true
			if NftName:
				
				PopUpMenu.TitlePass("NFT Won!")
				PopUpMenu.TextPass("Congratulations! You have won a free NFT. It will be generated and added to your collection shortly.")
			else:
				PopUpMenu.TitlePass("YOU POSSES ALL!")
				PopUpMenu.TextPass("Congratulations! You have all free NFTs. Visit element.market/collections/ethereum-frogs to get more.")
				
		"CLB":
			PopUpMenu.visible = true
			PopUpMenu.TitlePass("IQ Lost")
			PopUpMenu.TextPass("You lost 30 IQ. You will end up Brain Ded next time Be Careful with the 10 you have now!")
		"CLS":
			PopUpMenu.visible = true
			PopUpMenu.TitlePass("Slap Yourself")
			PopUpMenu.TextPass("KingFrog Says Slap Youself or KingFrog will find you wherever you are!")
		"CGB":
			JavaScriptBridge.eval("window.croakReward(30)")
			updateCroakCount()
			PopUpMenu.visible = true
			PopUpMenu.TitlePass("Croak Gained")
			PopUpMenu.TextPass("Great job! You gained 30 croaks. Keep spinning to earn even more!")
		"CGS":
			JavaScriptBridge.eval("window.croakReward(10)")
			updateCroakCount()
			PopUpMenu.visible = true
			PopUpMenu.TitlePass("Croak Boost")
			PopUpMenu.TextPass("You gained 10 croaks. Every bit counts, so keep going!")
		"FS":
			handleFrogPart()
			PopUpMenu.visible = true
			PopUpMenu.TitlePass("Frog Spin")
			PopUpMenu.TextPass("The frog is spinning again! Keep an eye out for your next reward.")
		_:
			print("Unknown reward.")


