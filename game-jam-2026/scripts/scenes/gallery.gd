extends Control

@onready var bottone_menuExit = $MenuExit
@onready var bottone_portrait1 =$HBoxContainer/Portrait1
@onready var bottone_portrait2 =$HBoxContainer/Portrait2
@onready var bottone_portrait3 =$HBoxContainer/Portrait3

@onready var bottone_destra =$Focus/destra
@onready var bottone_sinistra =$Focus/sinistra
@onready var bottone_reset =$Focus/reset
@onready var bottone_back =$Focus/back

@onready var portrait_desc =$Focus/TextureRect/portrait_desc
@onready var focus_area = $Focus
@onready var portrait_character =$Focus/Character

var index: int = 0
var array_nodi_control: Array[Control] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#load_gallery()
	carica_nodi_da_cartella("res://nodes/")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_menu_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/scenes/MainTitle.tscn")

func _on_destra_pressed() -> void:
	print (array_nodi_control.size())
	print (index)
	if (index < array_nodi_control.size()-1):
		index = index + 1
		mostra_personaggio(index)

func _on_sinistra_pressed() -> void:
	if (index > 0):
		index = index - 1
		mostra_personaggio(index)
		

func _on_reset_pressed() -> void:
	print("Reset focus")
	
	var file_path = array_nodi_control[index].scene_file_path
	
	if array_nodi_control[index] != null:
		array_nodi_control[index].queue_free()
	
	var nuova_scena = load("res://scripts/classes_and_objects/vuoto.tscn").instantiate()
	
	array_nodi_control[index] = nuova_scena
	
	if file_path != "" and FileAccess.file_exists(file_path) and file_path != "res://scripts/classes_and_objects/vuoto.tscn":
		var dir = DirAccess.open("res://")
		var error = dir.remove(file_path)
		
		if error == OK:
			print("File eliminato con successo: ", file_path)
		else:
			print("Errore durante l'eliminazione del file: ", error)
	
	mostra_personaggio(index)

func _on_portrait_1_pressed() -> void:
	focus_area.visible = true;
	index = 0
	if(index < array_nodi_control.size() - 1) :
		mostra_personaggio(index)
	
func _on_portrait_2_pressed() -> void:
	focus_area.visible = true;
	index = 1
	if(index < array_nodi_control.size() - 1):
		mostra_personaggio(index)

func _on_portrait_3_pressed() -> void:
	focus_area.visible = true;
	index = 2
	if(index < array_nodi_control.size()):
		mostra_personaggio(index)
	
func _on_back_pressed() -> void:
	focus_area.visible = false;
	
func carica_nodi_da_cartella(path: String) -> void:
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			# Filtriamo solo i file delle scene .tscn
			if !dir.current_is_dir() and file_name.ends_with(".tscn"):
				var full_path = path + "/" + file_name
				
				# 1. Carichiamo la risorsa della scena
				var scena_caricata = load(full_path) as PackedScene
				
				if scena_caricata:
					# 2. Istanziamo il nodo
					var istanza_nodo = scena_caricata.instantiate()
					
					# 3. Lo aggiungiamo all'array (rimane in memoria, non è ancora visibile)
					array_nodi_control.append(istanza_nodo)
					print("Nodo caricato e pronto: ", file_name)
			
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Errore: Percorso cartella non trovato!")

func mostra_personaggio(index: int):
	
	if(array_nodi_control.is_empty()):
		return
	
	for child in portrait_character.get_children():
		portrait_character.remove_child(child)
	
	var nuovo_ritratto = array_nodi_control[index]
	
	portrait_character.add_child(nuovo_ritratto)
	
	# Se il nodo ha uno script interno, puoi anche leggerne le variabili
	# portrait_name.text = nuovo_ritratto.nome_personaggio	
