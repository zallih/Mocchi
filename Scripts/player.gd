extends CharacterBody2D


const SPEED = 200.0
const JUMP_FORCE = -400.0
var isJumping := false
var playerLife := 3
var knockBack := Vector2.ZERO

@onready var rayRight := $rayCastRight as  RayCast2D
@onready var rayLeft := $rayCastLeft as  RayCast2D
@onready var animation := $anim as AnimatedSprite2D 
@onready var remoteTransform := $remote as RemoteTransform2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		isJumping = true
	elif is_on_floor():
		isJumping = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if isJumping == false:
			animation.play("run")
		elif isJumping == true:
			animation.play("jump")	
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")

	if knockBack != Vector2.ZERO:
		velocity = knockBack
	move_and_slide()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	#if body.is_in_group("enemies"):
		#queue_free()
	if playerLife < 0:
		queue_free()
	else:
		if rayRight.is_colliding():
			takeDamage(Vector2(-200,-200))
		elif rayLeft.is_colliding():
			takeDamage(Vector2(200,-200))

func followCamera(camera):
	var cameraPath = camera.get_path()
	remoteTransform.remote_path = cameraPath
	
func takeDamage(knockBackForce := Vector2.ZERO, duration := 0.25):
	playerLife -= 1
	
	if knockBackForce != Vector2.ZERO:
		knockBack = knockBackForce
		var knockBackTween := get_tree().create_tween()
		
		knockBackTween.parallel().tween_property(self, "knockBack", Vector2.ZERO, duration) 
		animation.modulate = Color(1, 0, 0, 1)
		knockBackTween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
func _input(event):
	if event is InputEventScreenTouch:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_FORCE
			isJumping = true
		elif is_on_floor():
			isJumping = false


func _on_head_collision_body_entered(body):
	if body.has_method("breakSprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.breakSprite()
	else:
		body.anim.play("hits")
		body.createCoin()
	
