// Verifica se o objeto está fora dos limites da sala
if (x < 0 or x > room_width or y < 0 or y > room_height) {
    if global.debug_mode{show_debug_message("Bala destruida!")}
	instance_destroy(); // Destroi o objeto
}