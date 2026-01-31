extends TextureButton
class_name PositionButton

@export var main : LevelController
@onready var deco_container : HBoxContainer = $DecorationContainer
@export var deco_buttons : Array[DecoRes]

func _ready() -> void:
	for decoration in deco_buttons:
		var button = DecorationButton.new()
		button.deco_res = decoration
		button.DecorationButtonPressed.connect(main._decoration_button_pressed)
		button.DecorationButtonPressed.connect(_on_decoration_pressed)
		deco_container.add_child(button)

func _on_pressed() -> void:
	deco_container.visible = !deco_container.visible

func _on_decoration_pressed(_deco_res) -> void:
	deco_container.hide()
