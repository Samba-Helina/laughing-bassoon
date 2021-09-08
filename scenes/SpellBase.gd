extends Area2D

var Spell_Target_Flag

var effect
var target = null setget setTarget, getTarget
var speed = 100 setget setSpeed, getSpeed
onready var ownSprite = $AnimatedSprite

var move = false
var direction = Vector2(0,0)
var velocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setTarget(new_target):
	target = new_target
	
func getTarget():
	return target

func setSpeed(new_speed):
	speed = new_speed

func getSpeed():
	return speed

func setSpellTargetFlag(newFlags):
	Spell_Target_Flag = newFlags

func startHoming(spawnLocation, target):
	position = spawnLocation
	if(target != null):
		move = true
		direction = position.direction_to(target)
		velocity = direction.normalized() * speed
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.distance_to(target) >= 10):
		# Find a way to move this thing
		direction = position.direction_to(target)
		velocity = direction.normalized() *  speed
		position += velocity * delta
		pass
		#velocity = move_and_slide(velocity)
	else:
		print("Poof!")
		queue_free()
	pass

# If you need stuff to interact properly with physics, do it here
func _physics_process(delta):
	pass

# Oh no, we have hit something! Do something
func _on_SpellBase_body_entered(body):
	# Here do the effect the spell would have on the target
	ownSprite.play("onHit")
	var layer = body.get_collision_layer()
	if(layer & Flags.COLLISION_FLAGS.PLAYER):
		# Ei heitä virheitä jostain syystä?
		body.takeDamage()
		pass
	if(layer & Flags.COLLISION_FLAGS.ENEMY):
		print("woosh")
		pass
	pass # Replace with function body.
