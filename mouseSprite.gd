extends Sprite2D

@onready var testDel = get_node_or_null("../testedel");

var snapM1x = 32;
var snapM1y = 32;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	global_position.x = snapped(get_global_mouse_position().x, snapM1x);
	global_position.y = snapped(get_global_mouse_position().y, snapM1y);
	
	pass
