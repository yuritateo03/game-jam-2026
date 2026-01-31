extends Control
class_name CharacterInterface

@onready var char_rect : TextureRect = $CharacterRect

@onready var up : TextureRect = $CharacterRect/Up
@onready var mask : TextureRect = $CharacterRect/Mask
@onready var down : TextureRect = $CharacterRect/Down
@onready var center : Control = $Center

@export var character : Texture
@export_multiline  var query : String
@export var char_name : String


func _ready() -> void:
	char_rect.texture = character

func add_up(deco : CompressedTexture2D):
	up.texture = deco

func add_mask(deco: CompressedTexture2D):
	mask.texture = deco
	
func add_down(deco: CompressedTexture2D):
	down.texture = deco

func add_center(deco: CompressedTexture2D):
	var sticker = DecorationSticker.new()
	sticker.texture = deco
	center.add_child(sticker)
