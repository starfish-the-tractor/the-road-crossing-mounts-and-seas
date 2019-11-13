extends Control

var current_archive_name: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func renew_list() -> void:
	self.clear_desc()
	var archives := (get_node("/root/Daemon") as Daemon).enum_archive()
	var list := find_node("ItemList")
	for child in list.get_children():
		list.remove_child(child)
	var template := load('res://scenes/ArchiveItem.tscn')
	for archive in archives:
		var item: Button = template.instance()
		list.add_child(item)
		item.text = archive.get_basename()
		item.connect("pressed", self, "_on_select_archive", [archive])

func show_desc(archive: Archive) -> void:
	(find_node("Description") as TextEdit).text = archive.get_description()
	(find_node("LoadArchive") as Button).disabled = false
	(find_node("DeleteArchive") as Button).disabled = false

func clear_desc() -> void:
	(find_node("Description") as TextEdit).text = "存档详情:"
	(find_node("LoadArchive") as Button).disabled = true
	(find_node("DeleteArchive") as Button).disabled = true

func _on_StartBtn_pressed() -> void:
	self.renew_list()
	(find_node("LaunchMenu") as Control).visible = false
	(find_node("ArchiveMenu") as Control).visible = true

func _on_QuitBtn_pressed() -> void:
	get_tree().quit()

func _on_select_archive(name) -> void:
	var daemon := get_node("/root/Daemon") as Daemon
	if daemon.load_archive(name):
		self.show_desc(daemon.archive)
		self.current_archive_name = name
	else:
		self.clear_desc()

func _on_NewArchive_pressed() -> void:
	var daemon := get_node("/root/Daemon") as Daemon
	daemon.new_archive()
	(find_node("ArchiveMenu") as Control).visible = false
	(find_node("NewArchiveMenu") as Control).visible = true

func _on_LoadArchive_pressed() -> void:
	self.enter_game()

func _on_DeleteArchive_pressed() -> void:
	var daemon := get_node("/root/Daemon") as Daemon
	daemon.delete_archive(self.current_archive_name)
	self.renew_list()

func _on_Back_pressed() -> void:
	(get_node("/root/Daemon") as Daemon).clear()
	self.clear_desc()
	(find_node("LaunchMenu") as Control).visible = true
	(find_node("ArchiveMenu") as Control).visible = false

func _on_Sure_pressed() -> void:
	var daemon := get_node("/root/Daemon") as Daemon
	daemon.save_as_archvie(self.current_archive_name)
	self.enter_game()

func _on_Cancel_pressed() -> void:
	(find_node("ArchiveMenu") as Control).visible = true
	(find_node("NewArchiveMenu") as Control).visible = false

func _on_NewArchiveName_text_changed() -> void:
	var name := (find_node("NewArchiveName") as TextEdit).text
	if name.get_extension() != "arch":
		name += ".arch"
	self.current_archive_name = name

func enter_game() -> void:
	get_tree().change_scene("res://scenes/AdventureRoad.tscn")
	pass
