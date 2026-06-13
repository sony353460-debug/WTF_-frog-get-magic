extends CanvasLayer
@onready var health_bar: ProgressBar = $Control/health_bar

func _ready():
	var player=get_tree().get_root().get_node("Node2D").get_node("player") as PlayertControllor
	player.playerHealthUpdated.connect(UpdateHealthBar)
func UpdateHealthBar(newValue:int,maxValue:int):
	var barValue=float(newValue)/float(maxValue)*100
	health_bar.value=barValue
