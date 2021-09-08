extends CanvasLayer

var buttons
var buttonPressed = []
var buttonInfo = []

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons = get_tree().get_nodes_in_group("Hotbar1")
	buttonPressed.resize(buttons.size())
	for buttonIndex in range(buttons.size()):
		buttons[buttonIndex].connect("button_up", self, "pressed_button", buttonIndex)
		buttonPressed[buttonIndex] = false

# Here change the icon for a spell for the duration of its cooldown
func casted_a_spell(spell_index, cooldown=0):
	pass

# Here we know what button is pressed and can handle its events
func pressed_button(button_id):
	
	pass
