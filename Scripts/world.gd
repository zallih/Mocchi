extends Node2D

@onready var player := $Player as CharacterBody2D
@onready var camera := $Camera as Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.followCamera(camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
