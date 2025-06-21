extends Area2D

@onready var animation := $anim as AnimatedSprite2D 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	$anim.play("Collect")
	
	 # Replace with function body.


func _on_anim_animation_finished() -> void:
	queue_free()
	
	# Replace with function body.
