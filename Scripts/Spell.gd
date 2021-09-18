extends Node
#class_name Spell

var _spell_hit
var _spell_type
var _target_type
var _target_object
var _target_coord

var _spawner = null

var _spell_node = preload("res://scenes/SpellBase.tscn")

var _spell_list = []
var _curr_spell

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

func addSpell(spellID, animation, collision):
	#var animations = load(folder + "/animations.tres")
	#var onHitCollision = load(folder + "/onHitCollision.tres")
	#var spellInstance = _spell_node.instance()
	#spellInstance.setAnimation(animations)
	
	# This version gets the animation data and collision data from loaded sources
	
	_spell_list.append({
		"animation" : animation,
		"collision" : collision
	})
	
	# This doesn't work
#	_spell_list[spellID] = {
#		"animation" : animation,
#		"collision" : collision
#	}
	pass

func changeSpell(spellID):
	if(_spell_list.size() <= spellID):
		print("SpellID too large to exist")
		return
	_curr_spell = spellID
	pass

func cast(cast_position, curr_target, curr_target_type=0):
	print("cast flags ", curr_target_type, _target_type)
	if(curr_target_type & _target_type):
		# New version with data from dicts
		var casted_spell = _spell_node.instance()
		casted_spell.position = cast_position
		casted_spell.setSpellTargetFlag(_target_type)
		casted_spell.setSpellTypeFlag(_spell_type)
		casted_spell.setCollision(_spell_list[_curr_spell]["collision"])
		casted_spell.setAnimations(_spell_list[_curr_spell]["animation"])
		print("Spell Casted with flags ", _target_type)
		if(_spawner != null):
			_spawner.add_child(casted_spell)
		match _spell_type:
			Flags.SPELL_TYPE.INSTANT:
				# There is no travel time
				casted_spell.target = curr_target as Vector2;
				casted_spell.startHoming(cast_position, curr_target)
				pass
			Flags.SPELL_TYPE.PROJECTILE:
				# There is a traveling object with it's own speed
				casted_spell.target = curr_target as Vector2;
				casted_spell.startHoming(cast_position, curr_target)
				pass
			Flags.SPELL_TYPE.CHANNEL:
				# Creates something
				pass
		
		# Old version after this. Use if testing basic stuff
		# The spell and the given target have same flags. You can most likely cast
#		var casted_spell = _spell_node.instance()
#		casted_spell.position = cast_position
#		casted_spell.setSpellTargetFlag(_target_type)
#		print("Spell Casted with flags ", _target_type)
#		if(_spawner != null):
#			_spawner.add_child(casted_spell)
#		match _spell_type:
#			Flags.SPELL_TYPE.INSTANT:
#				# There is no travel time
#				pass
#			Flags.SPELL_TYPE.PROJECTILE:
#				# There is a traveling object with it's own speed
#				casted_spell.target = curr_target as Vector2;
#				casted_spell.startHoming(cast_position, curr_target)
#				pass
#			Flags.SPELL_TYPE.CHANNEL:
#				# Creates something
#				pass
	else:
		# The spell fizzles. Prolly activate some fizzle effect?
		pass
	pass

