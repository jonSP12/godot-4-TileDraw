extends Sprite2D


@onready var mouseSprite1 = get_node_or_null("../../../mouseSprite");
@onready var _testDel = get_node_or_null("../../../testedel");

var draw_material;
var erase_material;

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_material = CanvasItemMaterial.new();
	draw_material.blend_mode = CanvasItemMaterial.BLEND_MODE_MIX;
	
	erase_material = CanvasItemMaterial.new();
	erase_material.blend_mode = CanvasItemMaterial.BLEND_MODE_SUB;
	


func _process(_delta):
	
	if ( _testDel.mouse_OnImage == true ):
		return;
	
	
	
	texture = mouseSprite1.texture;
	
	global_position.x = snapped(get_global_mouse_position().x, 32);
	global_position.y = snapped(get_global_mouse_position().y, 32);
	
	
	if ( Input.is_action_pressed("mouse_btn_left") ):
		visible = true;
	else:
		visible = false;
	
	
	
	
	if ( Input.is_action_just_pressed("ui_page_down") ):
		material = erase_material;
		
		mouseSprite1.modulate = Color(0, 0, 0, 0.5);
		
	elif ( Input.is_action_just_pressed("ui_page_up") ):
		material = draw_material;
		
		mouseSprite1.modulate = Color(1, 1, 1, 1);
	
	elif ( Input.is_action_just_pressed("ui_right") ):
		flip_h = true;
		mouseSprite1.flip_h  = true;
	elif ( Input.is_action_just_pressed("ui_left") ):
		flip_h = false;
		mouseSprite1.flip_h  = false;
	
	
	elif ( Input.is_action_just_pressed("ui_down") ):
		flip_v = true;
		mouseSprite1.flip_v  = true;
	elif ( Input.is_action_just_pressed("ui_up") ):
		flip_v = false;
		mouseSprite1.flip_v  = false;
	
	
