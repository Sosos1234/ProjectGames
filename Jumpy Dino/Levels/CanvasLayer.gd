extends CanvasLayer

@onready var button = $Button
@onready var button4 = $Button4
@onready var button2 = $Button2
@onready var button5 = $Button5
@onready var button3 = $Button3
@onready var button6 = $Button6
@onready var money1 = $Money2
@onready var money2 = $Money3
@onready var money3 = $Money4

func _ready():
	if Global.globalSkin != "spiderSkin" && Global.buttonz1 == true:
		button4.text = "Надеть!"
		money1.queue_free()
	if Global.globalSkin != "luffiSkin" && Global.buttonz2 == true:
		button5.text = "Надеть!"
		money2.queue_free()
	if Global.globalSkin != "cjSkin" && Global.buttonz3 == true:
		button6.text = "Надеть!"
		money3.queue_free()
	if Global.globalSkin == "spiderSkin" && Global.buttonz1 == true:
		button4.text = "Надето!"
		money1.queue_free()
	if Global.globalSkin == "luffiSkin" && Global.buttonz2 == true:
		button5.text = "Надето!"
		money2.queue_free()
	if Global.globalSkin == "cjSkin" && Global.buttonz3 == true:
		button6.text = "Надето!"
		money3.queue_free()
		
func _on_button_pressed():
	if Global.playerMoney >= 250:
		Global.playerMoney -= 250
		button.queue_free()
		money1.queue_free()
		Global.buttonz1 = true
		button4.text = "Надеть!"

func _on_button_2_pressed():
	if Global.playerMoney >= 500:
		Global.playerMoney -= 500
		button2.queue_free()
		money2.queue_free()
		Global.buttonz2 = true
		button5.text = "Надеть!"

func _on_button_3_pressed():
	if Global.playerMoney >= 1000:
		Global.playerMoney -= 1000
		button3.queue_free()
		money3.queue_free()
		Global.buttonz3 = true
		button6.text = "Надеть!"

func _on_button_4_pressed():
	Global.globalSkin = "cjSkin"
	
func _on_button_5_pressed():
	Global.globalSkin = "spiderSkin"
	
func _on_button_6_pressed():
	Global.globalSkin = "luffiSkin"
