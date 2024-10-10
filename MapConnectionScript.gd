extends Node2D

@export var Player = preload("res://Player/Player.tscn")


func _ready():
	multiplayer.peer_connected.connect(addplayer)
	addplayer(multiplayer.get_unique_id())


func addplayer(id = 1):
	var player = Player.instantiate()
	player.name = str(id)
	player.global_position = Vector2(300,300)
	call_deferred("add_child",player)


