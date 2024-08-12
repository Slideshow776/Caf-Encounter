extends Control

var faces := {
	"very angry": preload ("res://assets/faces/Very Angry.svg"),
	"serious": preload ("res://assets/faces/Serious.svg"),
	"driven": preload ("res://assets/faces/Driven.svg"),
	"eyes closed": preload ("res://assets/faces/Eyes Closed.svg"),
	"rage": preload ("res://assets/faces/Rage.png"),
	"annoyed": preload ("res://assets/faces/Annoyed.png"),
	"fear": preload ("res://assets/faces/Fear.svg"),
	"solemn": preload ("res://assets/faces/Solemn.svg"),
	"tired": preload ("res://assets/faces/Tired.svg"),
	"hectic": preload ("res://assets/faces/Hectic.svg"),
	"explaining": preload ("res://assets/faces/Explaining.png"),
	"smile": preload ("res://assets/faces/Smile.svg"),
	"contempt": preload ("res://assets/faces/Contempt.svg"),
}

var Dialogues = preload("res://scripts/dialogues.gd")  # Preload the script
var dialogues_instance = Dialogues.new()  # Create an instance of the script
var dialogue_items = dialogues_instance.dialogue_items  # Access the dialogue_items variable

var current_level := 5
var levels := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

@onready var rich_text_label = %RichTextLabel
@onready var buttons_v_box_container = %Buttons_VBoxContainer
@onready var body_a = %BodyA
@onready var body_a_original_rotation: float = body_a.rotation
@onready var expression_a = %ExpressionA
@onready var body_b = %BodyB
@onready var expression_b = %ExpressionB
@onready var animation_player = %AnimationPlayer
@onready var ambiant_sounds = %AmbiantSounds
@onready var toilet_sounds = %ToiletSounds


func _ready():
	rich_text_label.modulate.a = 0.0
	buttons_v_box_container.visible = false
	
	animation_player.play("intro")
	
	toilet_sounds.play()
		
	ambiant_sounds.play(randf() * ambiant_sounds.stream.get_length())
	var tween := create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(show_text.bind(0, false))
	tween.tween_property(ambiant_sounds, "volume_db", -10, 4.0)
	

func _input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func create_buttons(choices_data: Dictionary):
	buttons_v_box_container.visible = true
	_clear_previous_buttons()
		
	var buttons: Array[Button] = []
	
	# button setup
	for choice_text in choices_data:
		var button := Button.new()
		button.text = choice_text
		var target_line_idx: int = choices_data[choice_text]
		button.pressed.connect(show_text.bind(target_line_idx))

		# Create a new Theme for each button
		var theme := Theme.new()

		# Create a StyleBoxFlat for the normal state
		var normal_stylebox := StyleBoxFlat.new()
		normal_stylebox.bg_color = Color(0.0, 0.0, 0.0)  # Set the default color if needed
		normal_stylebox.corner_radius_bottom_left = 8
		normal_stylebox.corner_radius_bottom_right = 8
		normal_stylebox.corner_radius_top_right = 8
		normal_stylebox.corner_radius_top_left = 8
		normal_stylebox.content_margin_left = 11
		normal_stylebox.content_margin_top = 8
		normal_stylebox.content_margin_right = 11
		normal_stylebox.content_margin_bottom = 9
		
		# Create a StyleBoxFlat for hover state
		var hover_stylebox := StyleBoxFlat.new()

		# Set hover color based on target_line_idx
		if target_line_idx == -2:
			hover_stylebox.bg_color = Color("#670038") # red
		elif target_line_idx == -1:
			hover_stylebox.bg_color = Color("5c4100") # orange
		elif target_line_idx == 0:
			hover_stylebox.bg_color = Color("004136") # green
		
		# Set the corner radius for the hover state
		hover_stylebox.corner_radius_bottom_left = 8
		hover_stylebox.corner_radius_bottom_right = 8
		hover_stylebox.corner_radius_top_right = 8
		hover_stylebox.corner_radius_top_left = 8
		
		# Assign the normal and hover styles to the button's theme
		theme.set_stylebox("normal", "Button", normal_stylebox)
		theme.set_stylebox("hover", "Button", hover_stylebox)
		theme.set_stylebox("pressed", "Button", hover_stylebox)

		# Apply the theme to the button
		button.theme = theme

		# Add the button to the buttons array
		buttons.append(button)

		
	_add_buttons_in_random_order(buttons)


func show_text(item_index: int, is_animate_body_b: bool = true):	
	current_level += item_index	
	if current_level < 0 or current_level >= levels.size():
		_set_game_over()
		return
	
	var current_item: Dictionary = dialogue_items[levels[current_level]]
	levels.remove_at(current_level)
	
	#rich_text_label.text = "[center]" + current_item["text"] + "[/center]"
	rich_text_label.text = current_item["text"]
	expression_a.texture = faces[current_item["expressionA"]]
	expression_b.texture = faces[current_item["expressionB"]]
	create_buttons(current_item["choices"])
		
	# animations
	var tween := create_tween()
	var body_a_interval_duration = randf_range(1.0, 1.3)
	animate_text(tween, current_item["text"], body_a_interval_duration)
	animate_buttons(tween)
	animate_body_A(body_a_interval_duration)
	if is_animate_body_b:
		animate_body_B()
	
	
func animate_text(tween, text: String, interval_duration: float):
	var text_speed := 21.0
	var text_appearing_duration: float = text.length() / text_speed
	rich_text_label.modulate.a = 0.0
	rich_text_label.visible_ratio = 0.0
	tween.tween_interval(interval_duration)
	tween.tween_property(rich_text_label, "modulate:a", 1.0, 0.1)
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	

func animate_buttons(tween: Tween):
	for button: Button in buttons_v_box_container.get_children():
		button.disabled = true
		button.modulate.a = 0.0
		
	tween.finished.connect(func():
		var button_tween = create_tween()
		button_tween.tween_interval(0.5)
		for button: Button in buttons_v_box_container.get_children():
			button.disabled = false
			var duration := clampf(button.text.length() / 50.0, 0.3, 0.7)
			button_tween.tween_property(button, "modulate:a", 1.0, duration)
	)


func animate_body_A(interval_duration: float):
	var tween := create_tween()
	var amount := .025
	var duration := 0.04
	tween.tween_interval(interval_duration)
	tween.tween_property(body_a, "rotation", amount, duration)
	tween.tween_property(body_a, "rotation", -2*amount, 2*duration)
	tween.tween_property(body_a, "rotation", amount, duration)
	tween.tween_property(body_a, "rotation", -2*amount, 2*duration)
	tween.tween_property(body_a, "rotation", amount, duration)
	tween.tween_property(body_a, "rotation", -2*amount, 2*duration)
	tween.tween_property(body_a, "rotation", amount, duration)
	tween.tween_property(body_a, "rotation", -2*amount, 2*duration)
	tween.tween_property(body_a, "rotation", body_a_original_rotation, duration)


func animate_body_B():
	var tween := create_tween()
	var amount := .075
	var duration := 0.4
	#if randf() < 0.5:
		#tween.tween_property(body_b, "scale", Vector2(1.0 - amount, 1.0 + amount), duration)
	#else:
	tween.tween_property(body_b, "scale", Vector2(1.0 + amount, 1.0 - amount), duration)
	tween.tween_property(body_b, "scale", Vector2.ONE, duration)


func _clear_previous_buttons():
	for button in buttons_v_box_container.get_children():
		button.queue_free()


func _add_buttons_in_random_order(buttons: Array[Button]):
	buttons.shuffle()
	for button in buttons:
		buttons_v_box_container.add_child(button)


func _set_game_over():
	animation_player.play("outro")
	buttons_v_box_container.visible = false
	rich_text_label.visible = false
	
	var tween := create_tween()
	tween.tween_property(ambiant_sounds, "volume_db", 0, 0.5)
	tween.parallel()
	tween.tween_interval(1.25)
	tween.tween_property(body_a, "modulate:a", 0.0, 0.75)
	tween.tween_interval(0.75)
	tween.tween_property(%Background, "modulate:a", 0.0, 3.0)
	tween.parallel()
	tween.tween_property(ambiant_sounds, "volume_db", -80, 9.0)
