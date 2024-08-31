extends Node2D

@onready var shaderMaterial = $"../../ColorRect"

func _physics_process(delta):
	# Get the global mouse position
	var mouse_pos = get_global_mouse_position()
	
	# Convert viewport size to Vector2 to match mouse_pos type
	var viewport_size = Vector2(get_viewport_rect().size)
	
	# Normalize the mouse position to [0, 1] range
	mouse_pos /= viewport_size
	
	# Set the mouse_position parameter in the shader
	shaderMaterial.material.set_shader_parameter("mouse_position", mouse_pos)
