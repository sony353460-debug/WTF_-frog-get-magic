extends Node

# 定義存檔路徑 (user:// 是 Godot 專屬的本地安全存檔路徑)
const SAVE_PATH = "user://savegame.data"

# 自訂訊號：當金幣改變時，通知全遊戲有需要的 UI 自行刷新
signal coins_changed(new_amount: int)

var currentHealth:
	set(new_value):
		currentHealth=new_value
		emit_signal("playerHealthUpdated",currentHealth,MAX_HEALTH)
const  MAX_HEALTH=100

signal playerHealthUpdated(newValue,maxValue)

# 玩家的金幣數量，利用 setter 在改變時自動觸發訊號
var coins: int = 100:
	set(value):
		coins = value
		coins_changed.emit(coins) # 發射訊號

func _ready() -> void:
	currentHealth=MAX_HEALTH

	# 遊戲一啟動，自動讀取進度
	load_game()

# === 儲存系統 ===
func save_game() -> void:
	var save_data = {
		"coins": coins
		# 未來如果有「已購買的商品清單」，也可以記錄在這裡
	}
	
	# 將資料轉為 JSON 文字並寫入檔案
	var json_string = JSON.stringify(save_data)
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_line(json_string)
		file.close()
		print("遊戲已儲存！目前金幣：", coins)

# === 讀取系統 ===
func load_game() -> void:
	# 檢查檔案是否存在
	if not FileAccess.file_exists(SAVE_PATH):
		print("找不到存檔，使用預設值。")
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_line()
		file.close()
		
		# 解析 JSON 資料
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if parse_result == OK:
			var data = json.get_data()
			if data.has("coins"):
				coins = data["coins"]
			print("存檔讀取成功！目前金幣：", coins)
