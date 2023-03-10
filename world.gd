extends Node2D


const main_menu = "res://level/zone/main_menu.tscn"
const level_1 = "res://world.tscn"
@onready var final_score = $hud_layer/Control/GridContainer/Label
@onready var world_animation_player = $AnimationPlayer
@onready var score = $hud_layer/hud/score_container/score_label
@onready var score_sound = $hud_layer/hud/score_container/AudioStreamPlayer
@onready var player = $player
@onready var health_full = $hud_layer/hud/health_container/health_patch
@onready var health_sound = $hud_layer/hud/health_container/AudioStreamPlayer
@onready var zone = $base_zone
@onready var camera = $player/Camera2D
const HEART_UI_WIDTH = 15
const HEART_UI_HEIGHT = 15




func _ready():
	health_full.size.x = HEART_UI_WIDTH * player.health
#	player.global_position.x = 200

func _physics_process(delta):
	if !player.is_alive:
		if Input.is_action_just_pressed("jump"):
			get_tree().change_scene_to_file(main_menu)
		
func die():
	camera.current = false
	player.die()
	world_animation_player.play("finish")

func _on_player_player_hit_enemy():
	health_full.size.x = HEART_UI_WIDTH * player.health
	health_sound.play()
	if player.health <= 0:
		die()

func _on_player_player_hit_pickup(val):
	score.text = str(int(score.text) + val)
	final_score.text = score.text
	score_sound.play()



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "reset_to_menu":
		pass
		
func _on_player_player_complete_level():
	die()
