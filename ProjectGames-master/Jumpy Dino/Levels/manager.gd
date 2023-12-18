extends Node2D
var save_path = "res://savegame.save"
func save_game ():
	var file = FileAccess.open(Global.save_path, FileAccess.WRITE)
	file.store_var(Global.playerMoney)
	file.store_var(Global.globalSkin)
	file.store_var(Global.buttonz1)
	file.store_var(Global.buttonz2)
	file.store_var(Global.buttonz3)
func load_game ():
	var file = FileAccess.open(Global.save_path, FileAccess.READ)
	Global.playerMoney = file.get_var(Global.playerMoney)
	Global.globalSkin = file.get_var(Global.globalSkin)
	Global.buttonz1 = file.get_var(Global.buttonz1)
	Global.buttonz2 = file.get_var(Global.buttonz2)
	Global.buttonz3 = file.get_var(Global.buttonz3)

func _on_play_pressed():
	load_game()



func _on_shop_pressed():
	load_game()



func _on_button_pressed():
	save_game()

