extends AudioStreamPlayer

const level_music = preload("res://assets/sound/-12372.mp3")
const main_menu_music = preload("res://assets/sound/starlight-204347.mp3")
const frogCaught = preload("res://assets/sound/Frog-sound-ribbit.mp3")
const NFTsound = preload("res://assets/sound/goodresult-82807.mp3")
var SpinPlayer


func _play_music(music: AudioStream, volume=0.0):
	if stream==music:
		return
		
	stream=music
	volume_db=volume
	play()
	
func play_music_level():
	_play_music(level_music)
	
func play_mainmenu_music():
	_play_music(main_menu_music)
	
func play_FX(stream: AudioStream, volume=0.0):
	var fx_player=AudioStreamPlayer.new()
	fx_player.stream=stream
	fx_player.name="FX_PLAYER"
	fx_player.volume_db=volume
	add_child(fx_player)
	fx_player.play()
	await fx_player.finished
	fx_player.queue_free()

func play_frogSound():
	play_FX(frogCaught)
	
func playNFTSound():
	play_FX(NFTsound)
	
	
	
func SpinSoundPlayer(stream : AudioStream,volume = 0.0):
	SpinPlayer=AudioStreamPlayer.new()
	SpinPlayer.stream= stream
	SpinPlayer.name="SpinPlayer"
	SpinPlayer.volume_db=volume
	add_child(SpinPlayer)
	SpinPlayer.play()
	await SpinPlayer.finished
	SpinPlayer.queue_free()

func StopSpinPlayer():
	SpinPlayer.queue_free()
