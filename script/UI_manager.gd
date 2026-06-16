extends CanvasLayer
@onready var health_bar: ProgressBar = $Control/health_bar

func _ready():
	# 🔴 關鍵：直接連結全域腳本的訊號，不管換到哪個場景都能自動綁定！
	game_manager.playerHealthUpdated.connect(UpdateHealthBar)
	
	# 遊戲一開始或換場景時，主動刷新一次目前的血量 UI
	UpdateHealthBar(game_manager.currentHealth, game_manager.MAX_HEALTH)

func UpdateHealthBar(newValue:int, maxValue:int):
	var barValue = float(newValue) / float(maxValue) * 100
	health_bar.value = barValue
