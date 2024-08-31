extends Node2D

var spinning = false
var soundPlaying = false
var slowSoundPlayed = false
var spin_velocity = 0
var friction = 0.995  # Increased friction for a longer spin duration
var min_spin_velocity = 0.5  # Ensures the wheel slows down smoothly

const SpinSound = preload("res://assets/sound/WheelSpin1.mp3")
const SpinSoundSlow = preload("res://assets/sound/WheelSpin2.mp3")

func _ready():
	pass

func _process(delta):
	if spinning:
		if spin_velocity > min_spin_velocity:
			var current_angle = self.rotation
			current_angle += spin_velocity * delta
			spin_velocity *= friction
			self.rotation = current_angle
			
			if not soundPlaying:
				AudioPlayer.SpinSoundPlayer(SpinSound)
				soundPlaying = true
				slowSoundPlayed = false
			elif spin_velocity < 10 and not slowSoundPlayed:
				AudioPlayer.StopSpinPlayer()
				AudioPlayer.SpinSoundPlayer(SpinSoundSlow)
				slowSoundPlayed = true
		else:
			spin_velocity = 0
			spinning = false
			if soundPlaying:
				AudioPlayer.StopSpinPlayer()
				soundPlaying = false
