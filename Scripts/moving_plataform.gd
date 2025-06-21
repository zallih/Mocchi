extends Node2D

const waitDuration := 1.0

@onready var plataform := $plataform as AnimatableBody2D
@export var moveSpeed := 3.0 
@export var distance := 192
@export var moveX := true

var follow :=Vector2.ZERO
var plataformCenter := 16


func movePlataform():
	var moveDir = Vector2.RIGHT * distance if moveX else Vector2.UP * distance
	var duration = moveDir.length() / float(moveSpeed * plataformCenter) 
	var plataformTween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR)
	plataformTween.tween_property(self, "follow", moveDir, duration).set_ease(Tween.EASE_IN_OUT).set_delay(waitDuration)
	plataformTween.tween_property(self, "follow", Vector2.ZERO, duration).set_ease(Tween.EASE_IN_OUT).set_delay(duration + waitDuration * 2)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	movePlataform() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	plataform.position = plataform.position.lerp(follow, 0.5)
