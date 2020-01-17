class_name Grims_End_Dialog

export (String, FILE, "*.json") var dialogue_file_path : String

func interact() -> void:
	var dialogue : Dictionary = load_dialog(dialogue_file_path)
	yield(local_map.lay_dialog(dialogue) , "completed")
	emit_signal("finished")
