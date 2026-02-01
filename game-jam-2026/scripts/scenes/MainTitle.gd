extends Control

@onready var bottone_gioca = $HBoxContainer/Gioca
@onready var bottone_gallery = $HBoxContainer/Gallery
@onready var bottone_settings = $HBoxContainer/Settings
@onready var title = $RichTextLabel
@onready var focus_area = $Focus
@onready var label_nome = $Focus/baloon/namingb
@onready var bottone_start = $Focus/baloon/Start
@onready var settings = $Focus/baloon2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Focus/baloon2/MusicContainer/HSlider.value = db_to_linear(
		AudioServer.get_bus_volume_db(0)
	)
	
	$Focus/baloon2/SFXContainer/HSlider.value = db_to_linear(
		AudioServer.get_bus_volume_db(1)
	)
	
	if (Global.nome != ""):
		title.text = Global.nome + "'s boutique!"
		focus_area.visible = false;
	pass

func _input(event):
	if event.is_action_pressed("invio"):
		on_start_button_pressed()

func on_start_button_pressed() -> void:
	if (label_nome.text.length() <= 15):
		if (label_nome.text.is_empty() == false):
			Global.nome = label_nome.text
		else:
			Global.nome = "Player"
	else:
		Global.nome = label_nome.text.substr(0,15)
	title.text = Global.nome + "'s boutique!"
	focus_area.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_gioca_button_pressed():
	get_tree().change_scene_to_file("res://scripts/scenes/Gallery.tscn")

func _on_gallery_button_pressed():
	get_tree().change_scene_to_file("res://scripts/scenes/Gallery.tscn")

func _on_settings_button_pressed():
	focus_area.visible = true
	
	settings.visible = true

func on_gallery_button_pressed() -> void:
	pass # Replace with function body.


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		0, linear_to_db(value)
	)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		1, linear_to_db(value)
	)


func _on_exit_game_pressed() -> void:
	get_tree().quit()


func _on_backmenu_pressed() -> void:
	focus_area.visible = false
	
	settings.visible = false
