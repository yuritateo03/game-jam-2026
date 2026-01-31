extends TextureRect
class_name DecorationSticker

var draggable : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if draggable:
		global_position = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if draggable:
		global_position = get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			global_position = get_global_mouse_position()
			draggable = false
			process_mode = Node.PROCESS_MODE_DISABLED
