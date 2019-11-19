extends Viewport

signal PlayDiceFinish

var timer: Timer = Timer.new()
var pointTimer: Timer = Timer.new()

func _ready() -> void:
	timer.one_shot = true
	timer.autostart = false
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	pointTimer.one_shot = true
	pointTimer.autostart = false
	pointTimer.connect("timeout", self, "changePoint")

func timeout() -> void:
	emit_signal("PlayDiceFinish")

func changePoint() -> void:
	pass

func play() -> void:
	# var result := randi() % 6
	var state_machine := find_node("AnimationTree")["parameters/playback"] as AnimationNodeStateMachinePlayback
	state_machine.travel("PlayDice")
	timer.start(4)
	pass
