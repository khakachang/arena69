extends CanvasLayer

const target_scene_path = "res://scenes/home.tscn"

var loading_status : int
var progress : Array[float]
var count = 0
#@onready var progress_bar : ProgressBar = $ProgressBar

func _ready() -> void:
	$"Timer".start()
	# Request to load the target scene:
	ResourceLoader.load_threaded_request(target_scene_path)
	
func _process(_delta: float) -> void:
	# Update the status:
	loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	# Check the loading status:
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			pass
			#progress_bar.value = progress[0] * _delta * 30000 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			# When done loading, change to the target scene:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
		ResourceLoader.THREAD_LOAD_FAILED:
			# Well some error happend:
			print("Error. Could not load Resource")



func _on_timer_timeout():
	$"Label".text = "Loading."
	$"Timer2".start()
func _on_timer_2_timeout():
	$"Label".text = "Loading.."
	$"Timer3".start()

func _on_timer_3_timeout():
	$"Label".text = "Loading..."
	$"Timer".start()
