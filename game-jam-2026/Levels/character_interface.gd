extends Control
class_name CharacterInterface

@onready var char_rect : TextureRect = $CharacterRect

@onready var up : TextureRect = $CharacterRect/Up
@onready var mask : TextureRect = $CharacterRect/Mask
@onready var down : TextureRect = $CharacterRect/Down
@onready var center : Control = $Center

@export var character : Texture
@export_multiline  var query : String
@export var query_threshold : int
@export_multiline var pos_response : String
@export_multiline var neg_response : String
@export var query_tags_pos : Array[TagsRes]
@export var query_tags_neg : Array[TagsRes]
@export var char_name : String

var tags_pred : Array[TagsRes]

func _ready() -> void:
	char_rect.texture = character

func add_up(deco : DecoRes):
	up.texture = deco.image
	tags_pred.append(deco.tags)

func add_mask(deco: DecoRes):
	mask.texture = deco.image
	tags_pred.append(deco.tags)
	
func add_down(deco: DecoRes):
	down.texture = deco.image
	tags_pred.append(deco.tags)

func add_center(deco: DecoRes):
	var sticker = DecorationSticker.new()
	sticker.texture = deco.image
	tags_pred.append(deco.tags)
	center.add_child(sticker)

func calculate_result():
	var result_points = 0
	for label in query_tags_pos:
		for pred in tags_pred:
			result_points += check_pos_theme(pred.position, label.position, "pos")
			result_points += check_pos_theme(pred.theme, label.theme, "pos")
			result_points += check_color_subthemes(pred.colors, label.colors, "pos")
			result_points += check_color_subthemes(pred.subthemes, label.subthemes, "pos")
	for label in query_tags_neg:
		for pred in tags_pred:
			result_points += check_pos_theme(pred.position, label.position, "neg")
			result_points += check_pos_theme(pred.theme, label.theme, "neg")
			result_points += check_color_subthemes(pred.colors, label.colors, "neg")
			result_points += check_color_subthemes(pred.subthemes, label.subthemes, "neg")
	return result_points

func final_results() -> Dictionary:
	var result_points = calculate_result()
	if result_points < query_threshold:
		return {"response" : neg_response, "points" : result_points}
	if result_points >= query_threshold:
		return {"response" : pos_response, "points" : result_points}
	return {"response": "qualcosa non va", "points" : 0}

func check_pos_theme(pred, label, type:String):
	if pred == label :
		if type == "pos":
			return 10
		elif type == "neg":
			return -10
	else:
		return 0

func check_color_subthemes(pred, label, type:String):
	for elem_pred in pred:
		for elem_label in label:
			if elem_pred == elem_label:
				if type == "pos":
					return 10
				elif type == "neg":
					return -10
			else:
				return 0

func resize_all():
	up.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	up.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	mask.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	mask.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	down.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	down.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	for child : DecorationSticker in center.get_children():
		child.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		up.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
