extends CanvasLayer

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func save() -> void:
	var daemon := get_node("/root/Daemon") as Daemon
	daemon.save_archive()

# HUD event
func _on_MenuBtn_pressed() -> void:
	find_node("HUDRoot").visible = false
	find_node("Background").visible = true
	find_node("Menu").visible = true

func _on_DiceBtn_pressed() -> void:
	find_node("HUDRoot").visible = false
	find_node("Background").visible = true
	find_node("DiceView").visible = true
	get_parent().find_node("DiceViewport").play()

# basic menu
func _on_ContinueBtn_pressed() -> void:
	find_node("HUDRoot").visible = true
	find_node("Background").visible = false
	find_node("Menu").visible = false

func _on_SaveBtn_pressed() -> void:
	self.save()

func _on_SaveBackBtn_pressed() -> void:
	self.save()
	var daemon := get_node("/root/Daemon") as Daemon
	daemon.clear()
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_SettingBtn_pressed() -> void:
	find_node("Menu").visible = false
	find_node("SettingMenu").visible = true

# setting menu
func _on_SettingBackBtn_pressed() -> void:
	find_node("Menu").visible = true
	find_node("SettingMenu").visible = false

# dice event
func _on_DiceViewport_PlayDiceFinish() -> void:
	find_node("HUDRoot").visible = true
	find_node("Background").visible = false
	find_node("DiceView").visible = false
