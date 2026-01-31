extends TextureButton
class_name DecorationButton

signal DecorationButtonPressed(DecoRes)

var deco_res : DecoRes

func _ready() -> void:
	texture_normal = deco_res.image
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	emit_signal("DecorationButtonPressed", deco_res)
	
