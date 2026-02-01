extends Control

@onready var bottone_gioca = $HBoxContainer/Gioca
@onready var bottone_gallery = $HBoxContainer/Gallery
@onready var bottone_settings = $HBoxContainer/Settings
@onready var title = $RichTextLabel
@onready var focus_area = $Focus
@onready var label_nome = $Focus/baloon/namingb
@onready var bottone_start = $Focus/baloon/Start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	get_tree().change_scene_to_file("res://scripts/scenes/Gallery.tscn")


func on_gallery_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_game_pressed() -> void:
	get_tree().quit()
