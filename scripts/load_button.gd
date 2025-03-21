extends Button

func _ready():
	self.pressed.connect(_on_load_pressed)  # Connect button press signal

func _on_load_pressed() -> void:
	Global.load_score()  # Load previous score
	print("Load Pressed - Loaded Score: " + str(Global.player_score))
