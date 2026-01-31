extends Control

@onready var bottone_gioca = $HBoxContainer/Gioca
@onready var bottone_gallery = $HBoxContainer/Gallery
@onready var bottone_settings = $HBoxContainer/Settings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_gioca_button_pressed():
	get_tree().change_scene_to_file("res://scripts/scenes/Gallery.tscn")
	
func _on_gallery_button_pressed():
	get_tree().change_scene_to_file("res://scripts/scenes/Gallery.tscn")
func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scripts/scenes/Gallery.tscn")


func on_gallery_button_pressed() -> void:
	pass # Replace with function body.
