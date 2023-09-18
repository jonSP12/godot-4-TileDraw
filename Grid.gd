extends Node2D

@onready var view = $"../view";
@onready var port = $"../view/port";



func _draw():
	
	
	for i in range(view.position.x, port.size.y+1, 32): # horizontal line
		draw_line(Vector2(0,i), Vector2(port.size.x,i), Color(1, 1, 1, 0.05) , 1);
	
	for i in range(view.position.x, port.size.x+1, 32): # vertical line
		draw_line(Vector2(i,0), Vector2(i,port.size.y), Color(1, 1, 1, 0.05), 1);
