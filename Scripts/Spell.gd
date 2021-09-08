extends Node
#class_name Spell

var _spell_hit
var _spell_type
var _target_type
var _target_object
var _target_coord

var _spawner = null

var _spell_node = preload("res://scenes/SpellBase.tscn")

# This is ran when initializing the spell
func _init(target_type=0, spell_type=0):
	_target_type = target_type
	_spell_type = spell_type

func _ready():
	var spellTree = get_tree().get_nodes_in_group("Spells")
	for item in spellTree:
		if(item.name == "ProjectileHost"):
			_spawner = item
	if(_spawner == null):
		print("No spawner")

func setCurrTarget(newTarget):
	_target_type = newTarget
	
func setSpellType(newType):
	_spell_type = newType

func setEffect():
	pass

func cast(cast_position, curr_target, curr_target_type=0):
	if(curr_target_type & _target_type):
		# The spell and the given target have same flags. You can most likely cast
		var casted_spell = _spell_node.instance()
		casted_spell.position = cast_position
		casted_spell.setSpellTargetFlag(_target_type)
		print("Spell Casted with flags ", _target_type)
		if(_spawner != null):
			_spawner.add_child(casted_spell)
		match _spell_type:
			Flags.SPELL_TYPE.INSTANT:
				# There is no travel time
				pass
			Flags.SPELL_TYPE.PROJECTILE:
				# There is a traveling object with it's own speed
				casted_spell.target = curr_target as Vector2;
				casted_spell.startHoming(cast_position, curr_target)
				pass
			Flags.SPELL_TYPE.CHANNEL:
				# Creates something
				pass
	else:
		# The spell fizzles. Prolly activate some fizzle effect?
		pass
	pass

