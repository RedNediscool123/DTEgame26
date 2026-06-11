extends AudioStreamPlayer

func play_character_sound():
	if not playing:
		play()
