extends Control
class_name LevelController

@onready var game_interface : SplitContainer = $GameInterface
@onready var query_text : RichTextLabel = $GameInterface/QueryPanel/QueryText
@onready var timer : Timer = $GameInterface/VSplitContainer/Time_PauseContainer/TimerPanel/Timer
@onready var timer_label : Label = $GameInterface/VSplitContainer/Time_PauseContainer/TimerPanel/Label
@onready var pause_layer : CanvasLayer = $PauseLayer
@onready var result_layer : CanvasLayer = $ResultLayer
@onready var gallery_layer : CanvasLayer = $GalleryLayer
@onready var end_layer : CanvasLayer = $EndLayer
var scene_name_to_save : String

@export var characters_to_serve : Array[CharacterInterface]
var turn_idx : int = 0

func _ready() -> void:
	start_turn()

func _process(delta: float) -> void:
	timer_label.text = str(int(timer.time_left))

func start_turn():
	if (turn_idx + 1 <= len(characters_to_serve)):
		var turn_char = characters_to_serve[turn_idx]
		game_interface.split_offsets = [-100, 100]
		get_node("GameInterface/"+ turn_char.name).show()
		query_text.text = turn_char.query
		game_interface.show()
		turn_char.show()
		timer.start()
	else:
		end_level()
	

func end_turn():
	var scene = PackedScene.new()
	scene.pack(characters_to_serve[turn_idx])
	var scene_name = characters_to_serve[turn_idx].name
	ResourceSaver.save(scene, "res://TempFrames/"+ scene_name +".tscn")
	await get_tree().create_timer(2).timeout
	#POSIZIONAMENTO DEL RISULTATO CREATO
	game_interface.hide()
	result_layer.show()
	result_layer.get_node("Control/Frame/ImageLimit").add_child(scene.instantiate())
	var image_limit : PanelContainer = result_layer.get_node("Control/Frame/ImageLimit")
	var new_frame : CharacterInterface = result_layer.get_node("Control/Frame/ImageLimit").get_child(0) 
	new_frame.set_anchors_preset(Control.PRESET_FULL_RECT)
	new_frame.set_size(image_limit.size)
	new_frame.set_position(image_limit.position)
	new_frame.char_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	new_frame.resize_all()
	#CALCOLO DEL RISULTATO
	var results = characters_to_serve[turn_idx].final_results()
	var results_label :Label = result_layer.get_node("Control/Label")
	results_label.text = results["response"] + "\nPunteggio finale: " + str(results["points"])
	
func show_gallery():
	result_layer.hide()
	gallery_layer.show()

func end_level():
	game_interface.hide()
	end_layer.show()
	
func _decoration_button_pressed(deco_res : DecoRes):
	var turn_char = characters_to_serve[turn_idx]
	match deco_res.tags.position:
		0:
			turn_char.add_up(deco_res)
		1:
			turn_char.add_center(deco_res)
		2:
			turn_char.add_down(deco_res)
		3:
			turn_char.add_mask(deco_res)

func _on_timer_timeout() -> void:
	end_turn()


func _on_pause_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
	pause_layer.visible = !pause_layer.visible

func _on_conferm_result_button_pressed() -> void:
	var text_edit : LineEdit = result_layer.get_node("Control/TitleContainer/LineEdit")
	scene_name_to_save = text_edit.text
	show_gallery()
	var new_frame : CharacterInterface = result_layer.get_node("Control/Frame/ImageLimit").get_child(0)
	new_frame.queue_free()


func _on_portrait_1_pressed() -> void:
	var image_limit : Control = gallery_layer.get_node("Control/HBoxContainer/Portrait1/Control")
	var scene_name = characters_to_serve[turn_idx].name
	var packed_frame = load("res://TempFrames/" + scene_name + ".tscn")
	image_limit.add_child(packed_frame.instantiate())
	var new_frame : CharacterInterface = image_limit.get_child(0)
	new_frame.set_anchors_preset(Control.PRESET_FULL_RECT)
	new_frame.set_size(image_limit.size)
	new_frame.set_position(image_limit.position)
	new_frame.char_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	new_frame.resize_all()
	
	new_frame.char_name = scene_name_to_save
	var scene = PackedScene.new()
	scene.pack(new_frame)
	ResourceSaver.save(scene, "res://Nodes/Frame_1.tscn")

func _on_portrait_2_pressed() -> void:
	var image_limit : Control = gallery_layer.get_node("Control/HBoxContainer/Portrait2/Control2")
	var scene_name = characters_to_serve[turn_idx].name
	var packed_frame = load("res://TempFrames/" + scene_name + ".tscn")
	image_limit.add_child(packed_frame.instantiate())
	var new_frame : CharacterInterface = image_limit.get_child(0)
	new_frame.set_anchors_preset(Control.PRESET_FULL_RECT)
	new_frame.set_size(image_limit.size)
	new_frame.set_position(image_limit.position)
	new_frame.char_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	new_frame.resize_all()
	
	new_frame.char_name = scene_name_to_save
	var scene = PackedScene.new()
	scene.pack(new_frame)
	ResourceSaver.save(packed_frame, "res://Nodes/Frame_2.tscn")

func _on_portrait_3_pressed() -> void:
	var image_limit : Control = gallery_layer.get_node("Control/HBoxContainer/Portrait3/Control3")
	var scene_name = characters_to_serve[turn_idx].name
	var packed_frame = load("res://TempFrames/" + scene_name + ".tscn")
	image_limit.add_child(packed_frame.instantiate())
	var new_frame : CharacterInterface = image_limit.get_child(0)
	new_frame.set_anchors_preset(Control.PRESET_FULL_RECT)
	new_frame.set_size(image_limit.size)
	new_frame.set_position(image_limit.position)
	new_frame.char_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	new_frame.resize_all()
	
	new_frame.char_name = scene_name_to_save
	var scene = PackedScene.new()
	scene.pack(new_frame)
	ResourceSaver.save(packed_frame, "res://Nodes/Frame_3.tscn")

func _on_exit_gallery_button_pressed() -> void:
	gallery_layer.hide()
	var turn_char = characters_to_serve[turn_idx]
	get_node("GameInterface/"+ turn_char.name).hide()
	turn_idx += 1
	start_turn()
