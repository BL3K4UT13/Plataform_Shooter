 var _key_up = keyboard_check(ord("W")); //cima
var _key_down = keyboard_check(ord("S")); //Abaixa
var _key_left = keyboard_check(ord("A")); //Esquerda
var _key_right = keyboard_check(ord("D")); //Direita	

var _key_shoot = keyboard_check_pressed(ord("J")) //atira
var _key_jump = keyboard_check_pressed(vk_space) //pula

#region Movimentação/Colisão
if global.player_state != "down"{
var _move = _key_right - _key_left

hspd = _move * spd; 

}

vspd = vspd + grv;

if	(hspd != 0) image_xscale = 2 * sign(hspd);

if place_meeting(x+hspd,y,obj_wall){	
	
	while(!place_meeting(x+sign(hspd),y,obj_wall)){
		   
		x = x + sign(hspd)
		
	}
	hspd = 0
}

x = x + hspd  ;

//COLISÃO VERTICAL

if place_meeting(x,y+vspd,obj_wall){	
	
	while(!place_meeting(x,y+sign(vspd),obj_wall)){
		
		y = y + sign(vspd)		
		
	}
	
	vspd = 0;
}

y = y + vspd;

#endregion

#region Pular/JumpShoot

if place_meeting(x,y+1,obj_wall){ // reseta o pulo
	jumps = 1
}

if _key_jump and jumps > 0 { //verifica se o player pode pular
	if (global.player_state =="free" or global.player_state =="down"){ 
		global.player_state = "jump"	
	}
	if global.player_state == "jump"{ //efetivamente pula
		jumps -= 1
		vspd =- jump_high	
	}
}else{
	
	if global.player_state == "jump" && place_meeting(x,y+1,obj_wall){ //reseta o player state
	global.player_state = "free"
	}

}

#endregion

#region Atirar

var _xx = x + (32 *sign(image_xscale))
var _yy = y - 8 //posição da bala em relação ao jogador

if _key_shoot and global.player_state == "free"{
	if hspd != 0 {global.player_state = "run_shoot"}
	else {global.player_state = "idle_shoot"}
	
	/*if global.player_state == "idle_shoot"{
		sprite_index = spr_player_idle_shoot
			if image_index > image_number -1 {
				global.player_state = "free"
			}
		}*/
	
	var _spd = 10 * sign(image_xscale)
		
	with (instance_create_layer(_xx,_yy,"Bullets",obj_bullet)){
		speed = _spd
	}		
	global.player_state = "free"
}


#endregion

#region Agachar

if _key_down and global.player_state == "free"{
	global.player_state = "down"	
	if global.player_state == "down"{
		sprite_index = spr_player_down
		hspd = 0
	}
}

if !_key_down and global.player_state == "down"{
	global.player_state = "free"		
}

#endregion

#region Sprites

if global.player_state == "jump"{
	sprite_index = spr_player_jump			
}

if vspd > 0{
	global.player_state = "fall"
	if global.player_state == "fall"{
		sprite_index = spr_player_fall
	}
}else{
	if place_meeting(x,y+1,obj_wall) and global.player_state == "fall"{
		global.player_state = "free"
	}
}

if hspd == 0 and global.player_state == "free"{	
	if place_meeting(x,y+1,obj_wall){
		sprite_index = spr_player_idle
	}	
}
	
if hspd != 0 and global.player_state == "free"{	
	if place_meeting(x,y+1,obj_wall){	
		sprite_index = spr_player_run
	}	
}

#endregion