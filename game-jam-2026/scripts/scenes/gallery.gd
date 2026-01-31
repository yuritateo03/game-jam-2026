extends Control

@onready var bottone_menuExit = $MenuExit
@onready var bottone_portrait1 =$HBoxContainer/Portrait1
@onready var bottone_portrait2 =$HBoxContainer/Portrait2
@onready var bottone_portrait3 =$HBoxContainer/Portrait3

@onready var bottone_destra =$Focus/destra
@onready var bottone_sinistra =$Focus/sinistra
@onready var bottone_reset =$Focus/reset
@onready var bottone_back =$Focus/back

@onready var portrait_name =$Focus/TextureRect/portrait_name
@onready var focus_area = $Focus

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#load_gallery()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_menu_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/scenes/MainTitle.tscn")

func _on_destra_pressed() -> void:
	print("Prossimo portrait")
	##carica nodo successivo

func _on_sinistra_pressed() -> void:
	print("Portrait precedente")
	##carica nodo precedente

func _on_reset_pressed() -> void:
	print("Reset focus")
	##resetta il nodo caricato 

func _on_portrait_1_pressed() -> void:
	focus_area.visible = true;
	##carica nodo1 
	
func _on_portrait_2_pressed() -> void:
	focus_area.visible = true;
	##carica nodo2

func _on_portrait_3_pressed() -> void:
	focus_area.visible = true;
	##carica nodo3
	
func _on_back_pressed() -> void:
	focus_area.visible = false;
	##togliere il nodo caricato?
	
