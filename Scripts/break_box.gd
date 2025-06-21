extends CharacterBody2D

const boxPieces = preload("res://Prefabs/box_pieces.tscn")
const coinInstance = preload("res://Prefabs/coinRigid.tscn")

@onready var animationBox := $anim as AnimationPlayer
@onready var spawnCoin := $spawCoin as Marker2D
 
@export var pieces : PackedStringArray
@export var hitpoints := 3
var impulse := 200

func breakSprite():
	for piece in pieces.size():
		var pieceInstance = boxPieces.instantiate()
		get_parent().add_child(pieceInstance)
		pieceInstance.get_node("texture").texture = load(pieces[piece])
		pieceInstance.global_position = global_position
		pieceInstance.apply_impulse(Vector2(randi_range(-impulse, impulse), randi_range(-impulse, -impulse * 2)))
	queue_free()
	
	
func createCoin():
	var coin = coinInstance.instantiate()
	get_parent().call_deferred("add_child", coin)
	coin.global_position = spawnCoin.global_position
	coin.apply_impulse(Vector2(randi_range(-50,50), -150)) 
	
