extends AnimatedSprite2D

var clickable = false
var fadeout = false
var shaderValue = 1.0 # Initialize shaderValue for each instance
var speed = 0.03
var nft_generated  = false
var nftName = null

func _ready():
	self.visible = true
	self.material = self.material.duplicate()
	shaderValue = material.get_shader_parameter("dissolve_value")

func _process(delta):
	clicked()

func clicked():
	if Input.is_action_just_pressed("frog_click") and clickable == true:
		clickable = false
		fadeout = true
		
func _on_area_2d_mouse_entered():
	clickable = true

func _on_area_2d_mouse_exited():
	clickable = false

func _physics_process(delta):
	if fadeout == true:
		shaderValue -= speed
		shaderValue = clamp(shaderValue, 0.0, 1.0)
		material.set_shader_parameter("dissolve_value", shaderValue)
		if shaderValue == 0.0:
			self.visible = false
			if not nft_generated:
				nft_generated = true
				nftName = GlobalScript.GenerateNFT(self.animation)
