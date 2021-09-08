extends KinematicBody2D

onready var GUI
onready var Spell = get_node("SpellNode")
onready var animation_tree = get_node("AnimationTree")
onready var state_machine = animation_tree.get("parameters/playback")

#var Spell = preload("res://Scripts/Spell.gd")
var newSpell;

export (int) var speed = 200
var acting = false

# This is the building block for stats
# Initialized with basic values for most basic stats
var player_attributes = {
	"strength" : 10,
	"constitution" : 10,
	"charisma" : 10,
	"dexterity" : 10,
	"intelligence" : 10,
	"wisdom" : 10
}

var direction = Vector2()
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.travel("Idle")
	#newSpell = Spell.new(Flags.CURR_TARGET.TARGET_COORD, Flags.SPELL_TYPE.PROJECTILE)
	Spell.setCurrTarget(Flags.CURR_TARGET.TARGET_COORD)
	Spell.setSpellType(Flags.SPELL_TYPE.PROJECTILE)
	Spell.setEffect()
	pass

func get_input():
	direction = Vector2()
	if Input.is_action_pressed("game_right"):
		direction.x += 1
	if Input.is_action_pressed("game_left"):
		direction.x -= 1
	if Input.is_action_pressed("game_up"):
		direction.y -= 1
	if Input.is_action_pressed("game_down"):
		direction.y += 1
	direction = direction.normalized()
	if(direction.length() != 0):
		animation_tree.set('parameters/Idle/blend_position', direction)
		animation_tree.set('parameters/Walk/blend_position', direction)
	velocity = direction *  speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(animation_tree.get('parameters/Idle/blend_position'))
	pass

# Called every physics calc
func _physics_process(delta):
	get_input()
	if(acting):
		pass
	else:
		velocity = move_and_slide(velocity)
		if(velocity.length() != 0):
			state_machine.travel("Walk")
		else:
			state_machine.travel("Idle")


func _unhandled_input(event):
	var target = Vector2()
	if(event.is_action_pressed("hotbar1")):
		
		pass
	if (event.is_action_pressed("left_click")):
		acting = true
		target = get_global_mouse_position()
		Attack(target)
	elif (event.is_action_pressed("right_click")):
		acting = true
		target = get_global_mouse_position()
		Cast(target)

func Attack(target):
	animation_tree.set("parameters/Attack/blend_position", position.direction_to(target))
	state_machine.travel("Attack")
	# Here we delay the function for a little while until we can stop the action
	yield(get_tree().create_timer(0.4), "timeout")
	acting = false
	
func Cast(target):
	animation_tree.set("parameters/Cast/blend_position", position.direction_to(target))
	state_machine.travel("Cast")
	Spell.cast(position, target, Flags.CURR_TARGET.TARGET_COORD)
	# Here we delay the function for a little while until we can stop the action
	yield(get_tree().create_timer(0.8), "timeout")
	acting = false

func takeDamage():
	print("Ouch")

func _on_Sword_area_entered(area):
	print("Hurrdurr")
	pass # Replace with function body.
