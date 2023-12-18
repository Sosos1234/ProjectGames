extends CanvasLayer

@onready var button = $Button
@onready var button4 = $Button4
@onready var button2 = $Button2
@onready var button5 = $Button5
@onready var button3 = $Button3
@onready var button6 = $Button6
@onready var button8 = $Button8

@onready var money1 = $Money2
@onready var money2 = $Money3
@onready var money3 = $Money4

var iconIsWeared = preload("res://Sprites/235.png")
var iconIsWearing = preload("res://Sprites/234005.png")

func _ready():
	if Global.globalSkin != 0 && Global.buttonz2 == true:
		button4.icon = iconIsWearing
		money2.queue_free()
	if Global.globalSkin != 1 && Global.buttonz3 == true:
		button6.icon = iconIsWearing
		money3.queue_free()
	if Global.globalSkin != 2 && Global.buttonz1 == true:
		button4.icon = iconIsWearing
		money1.queue_free()
	if Global.globalSkin != 3:
		button8.icon = iconIsWearing
	if Global.globalSkin == 0 && Global.buttonz2 == true:
		button5.icon = iconIsWeared
		money2.queue_free()
	if Global.globalSkin == 1 && Global.buttonz3 == true:
		button6.icon = iconIsWeared
		money3.queue_free()
	if Global.globalSkin == 2 && Global.buttonz1 == true:
		button4.icon = iconIsWeared
		money1.queue_free()
	if Global.globalSkin == 3:
		button8.icon = iconIsWeared


func _process(delta):
	if Global.globalSkin != 0 && Global.buttonz2 == true:
		button5.icon = iconIsWearing
	if Global.globalSkin != 1 && Global.buttonz3 == true:
		button6.icon = iconIsWearing
	if Global.globalSkin != 2 && Global.buttonz1 == true:
		button4.icon = iconIsWearing
	if Global.globalSkin != 3:
		button8.icon = iconIsWearing
	if Global.globalSkin == 0 && Global.buttonz2 == true:
		button5.icon = iconIsWeared
	if Global.globalSkin == 1 && Global.buttonz3 == true:
		button6.icon = iconIsWeared
	if Global.globalSkin == 2 && Global.buttonz1 == true:
		button4.icon = iconIsWeared
	if Global.globalSkin == 3:
		button8.icon = iconIsWeared
	button4.position = Vector2i(91, 386)
	button5.position = Vector2i(361, 386)
	button6.position = Vector2i(91, 667)

func _on_button_pressed():
	if Global.playerMoney >= 250:
		Global.playerMoney -= 250
		$"../Buy".playing = true
		button.queue_free()
		money1.queue_free()
		Global.buttonz1 = true
		button4.icon = iconIsWearing
		save_game()

func _on_button_2_pressed():
	if Global.playerMoney >= 500:
		Global.playerMoney -= 500
		$"../Buy".playing = true
		button2.queue_free()
		money2.queue_free()
		Global.buttonz2 = true
		button5.icon = iconIsWearing
		save_game()

func _on_button_3_pressed():
	if Global.playerMoney >= 1000:
		Global.playerMoney -= 1000
		$"../Buy".playing = true
		button3.queue_free()
		money3.queue_free()
		Global.buttonz3 = true
		button6.icon = iconIsWearing
		save_game()

func _on_button_4_pressed():
	$"../TapOnButton".playing = true
	Global.globalSkin = 2
	save_game()

func _on_button_5_pressed():
	$"../TapOnButton".playing = true
	Global.globalSkin = 0
	save_game()

func _on_button_6_pressed():
	$"../TapOnButton".playing = true
	Global.globalSkin = 1
	save_game()

func _on_button_8_pressed():
	$"../TapOnButton".playing = true
	Global.globalSkin = 3
	save_game()
func save_game ():
	var file = FileAccess.open(Global.save_path, FileAccess.WRITE)
	file.store_var(Global.playerMoney)
	file.store_var(Global.globalSkin)
	file.store_var(Global.buttonz1)
	file.store_var(Global.buttonz2)
	file.store_var(Global.buttonz3)
