extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -400.0
@onready var anim := $Anim as AnimationPlayer
var direction := -1
@onready var wallDetector := $wallDetector as RayCast2D
@onready var texture := $Texture as Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if wallDetector.is_colliding():
		direction *= -1
		wallDetector.scale.x *= -1
	
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	
	velocity.x = direction * SPEED * delta
	
	move_and_slide()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hurt":
		queue_free()
