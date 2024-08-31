extends Node

var LastUnlockedLevel = 0
var CurrentLevel
var PlayersCroak = 0

var PresentNfts = ["CF", "SGF","WF","FF","PF","BF"]
var nfts_generated = []
var musicPlaying = false

var externalator = JavaScriptBridge.get_interface("externalator")

var nft_callback = JavaScriptBridge.create_callback(_on_get_nft)
var get_balance_callback = JavaScriptBridge.create_callback(_on_get_balance)
var level_callback = JavaScriptBridge.create_callback(_on_level_complete)

func _ready():
	externalator.addGodotFunction('getNFT',nft_callback)
	externalator.addGodotFunction('getBalance',get_balance_callback)
	externalator.addGodotFunction('levelComplete',level_callback)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if CurrentLevel != null and musicPlaying == false:
		AudioPlayer.play_music_level()
		musicPlaying = true


func GenerateNFT(Name):
	if Name in PresentNfts and Name not in nfts_generated:
		AudioPlayer.playNFTSound()
		# dont forget to run callback after this
		JavaScriptBridge.eval("window.generateNFT('" + Name + "')")
		return Name
	else:
		return null

func GenerateRandomNFT():
	var available_nfts = PresentNfts.filter(func(nft):
		return nft not in nfts_generated
	)
	if available_nfts.size() > 0:
		var random_nft = available_nfts[randi() % available_nfts.size()]
		GenerateNFT(random_nft)
		return random_nft
	return null 

func handleCompletion(LevelNumber):
	if LevelNumber >= LastUnlockedLevel:
		JavaScriptBridge.eval("window.levelComplete('" + str(LevelNumber) + "')")

func _on_get_nft(name):
	nfts_generated.append(name[0])

func _on_get_balance(balance):
	PlayersCroak = int(balance[0])

func _on_level_complete(LevelNumber):
	LastUnlockedLevel = int(LevelNumber[0]) + 1
