if keyboard_check(ord("R")) {
	game_restart()
}

if keyboard_check_pressed(vk_f1){
	if global.debug_mode == false {
		global.debug_mode = true
	} else{global.debug_mode = false}
}

if global.debug_mode{
	show_debug_message(string(global.player_state))
}

global.key_action = keyboard_check_pressed(ord("K"))
