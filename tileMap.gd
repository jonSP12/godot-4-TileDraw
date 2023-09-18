extends Node2D

var grid_X = 32*5;
var grid_Y = 32*5;

var grid_Widh = grid_X + ( 32*10 );
var grid_Height = grid_Y + ( 32*10 );

var font;



var Arr2D = [
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 1, 0, 0, 0, 0, 1, 0, 1],
	[1, 0, 0, 1, 1, 1, 1, 0, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
	];


var rows;
var cols;
var cellWidth;
var cellHeight;




func _setup():
	var size = Vector2(640, 640);
	#rows = 10;
	#cols = 10;
	rows = Arr2D.size();
	cols = Arr2D[0].size();
	
	cellWidth = 32;
	cellHeight = 32;

func _renderMap(xPos, yPos):
	
	for i in range(0, rows):
		
		
		for j in range(0, cols):
			
			match Arr2D[i][j]:
				0:
					draw_rect(Rect2( xPos + j * cellWidth, yPos + i * cellHeight, cellWidth, cellHeight), Color.GRAY, true );
					
					#draw_string(font, Vector2(xPos + j * cellWidth+10, yPos + i * cellHeight+20 ), "p " + str( Arr2D[i][j] ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color.RED );
					
				1:
					draw_rect(Rect2( xPos + j * cellWidth, yPos + i * cellHeight, cellWidth, cellHeight), Color.RED, true );
					
					#draw_string(font, Vector2(xPos + j * cellWidth+10 , yPos + i * cellHeight+20 ), "p " + str( Arr2D[i][j] ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color.GRAY );
					
				_:
					print("something is wrong");
			
			
			draw_string(font, Vector2(xPos + j * cellWidth+10, yPos + i * cellHeight+20 ), "" + str( Vector2(i,j) ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 8, Color.YELLOW );
			#draw_string(font, Vector2(xPos + j * cellWidth+10 , yPos + i * cellHeight+20 ), "y " + str( j ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color.YELLOW );
		
	




func _ready():
	#font = FontFile.new();
	#font.font_data = load('res://fonts/big_noodle_titling_0.ttf');
	
	font = ThemeDB.fallback_font;
	
	print( Arr2D[0][1] );
	
	
	_setup();
	
	
	

func _process(_delta):
	
	if ( Input.is_action_just_pressed("ui_down") ):
		
		Arr2D = [
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
			[1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 1, 1, 1, 1, 0, 0, 1],
			[1, 0, 0, 1, 1, 1, 1, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
		];
		
		queue_redraw();
	elif ( Input.is_action_just_pressed("ui_up") ):
		
		Arr2D = [
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 1, 0, 0, 0, 0, 1, 0, 1],
			[1, 0, 0, 1, 1, 1, 1, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
		];
		
		queue_redraw();
	
	
	




func _draw():
	
	_renderMap(grid_X, grid_Y);
	
	
	for i in range(grid_X, grid_Height + 1, 32): # horizontal line
		draw_line(Vector2(grid_X,i), Vector2(grid_Widh,i), Color.GOLDENROD , 1);
		
		#draw_string(font, Vector2(grid_X,i), "X " + str( i ) , HORIZONTAL_ALIGNMENT_CENTER, -1, 15 );
		
	
	for j in range(grid_X, grid_Widh + 1, 32): # vertical line
		draw_line(Vector2(j,grid_Y), Vector2(j, grid_Height ), Color.GOLDENROD , 1);
		
		#draw_string(font, Vector2(j,grid_Y), "Y " + str( j ) , HORIZONTAL_ALIGNMENT_CENTER, -1, 15 );
	
	
	
	
	#draw_rect(Rect2(grid_X, grid_Y, 32, 32), Color.RED, true );
	#draw_string(font, Vector2(360, 50), "hello: " + str( "1" ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 10 );
	
	
	
	
	
	




