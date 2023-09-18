extends Node2D

var font = ThemeDB.fallback_font;

var mXG = 0;
var mYG = 0;
var mGpos = Vector2 (0, 0);

var grid1X = 16;
var grid1Y = 16;
var grid1W = grid1X+1 + ( 32*23 );
var grid1H = grid1Y+1 + ( 32*18 );

@onready var image = get_node_or_null("TextRect");
var imageSizeX = 0;
var imageSizeY = 0;

var imageEnter = 0;

var mouse_tex = 0
var allRect = Rect2(0, 0, 32, 32 );
var selectRect = Rect2(0, 0, 32, 32 );

var temp_mX = 0;
var temp_mY = 0;


var mouseGroup = {
	'Fnum': []
}

#var mouseGroup = { "cords": Vector2(0, 0), "img": 0 }


var canvasTex = {};



func _ready():
	imageSizeX = image.size.x;
	imageSizeY = image.size.y;
	
	mouse_tex = ImageTexture.create_from_image(image.texture.get_image().get_region( allRect ) );
	


func _input(event):
	
	if ( Input.is_action_just_pressed("mouse_btn_left") ):
		
		temp_mX = snapped(  get_global_mouse_position().x, 32 );
		temp_mY = snapped(  get_global_mouse_position().y, 32 );
		
		
		
	elif ( Input.is_action_pressed("mouse_btn_left")  && imageEnter == 1 ):
		
		if event is InputEventMouseMotion:
			var mmW = snapped(  get_global_mouse_position().x, 32 ) - temp_mX;
			var mmH = snapped(  get_global_mouse_position().y, 32 ) - temp_mY;
			
			allRect = Rect2(temp_mX-32, temp_mY-32, mmW, mmH );
			selectRect = Rect2(temp_mX-16, temp_mY-16, mmW, mmH );
			
			
	elif ( Input.is_action_just_released("mouse_btn_left")  && imageEnter == 1 ):
		var absRect = allRect.abs()
		if ( absRect.has_area( ) ):
			mouse_tex = ImageTexture.create_from_image(image.texture.get_image().get_region( absRect ) );
			
			
			for i in range(0, mouse_tex.get_image().get_size().x,32 ):
				for j in range(0,  mouse_tex.get_image().get_size().y, 32):
					
					mouseGroup.Fnum.append(  { "cords": Vector2(i, j), "img": ImageTexture.create_from_image(mouse_tex.get_image().get_region( Rect2( i, j, 32, 32) ) ) } );  
					
					print(mouseGroup.Fnum[mouseGroup.Fnum.size()-1] )
				
				
			
			mouse_tex2 = ImageTexture.create_from_image(mouse_tex.get_image().get_region( allRect10 ) );
			mouse_tex3 = ImageTexture.create_from_image(mouse_tex.get_image().get_region( allRect11 ) );
			mouse_tex4 = ImageTexture.create_from_image(mouse_tex.get_image().get_region( allRect12 ) );
			
			
			
		
	

var mouse_tex2 = 0
var mouse_tex3 = 0
var mouse_tex4 = 0
var mouse_tex5 = 0
var allRect10 = Rect2(0, 0, 32, 32 );
var allRect11 = Rect2(0, 0, 32, 32 );
var allRect12 = Rect2(0, 0, 32, 32 );
var allRect13 = Rect2(0, 0, 32, 32 );

func _process(_delta):
	
	mXG = snapped(  get_global_mouse_position().x, 32 );
	mYG = snapped(  get_global_mouse_position().y, 32 );
	mGpos = Vector2 (mXG, mYG);
	
	if ( mXG > 0 && mYG > 0 && mXG < 1249 ):
		if ( mXG < imageSizeX+1 && mYG < imageSizeY+1 ):
			imageEnter = 1; # on image
		elif ( mXG > imageSizeX+32 && mYG < imageSizeY+1 ):
			imageEnter = 2; # on canvas
		else:
			imageEnter = 0;
	else:
		imageEnter = 0;
	
	
	if ( imageEnter == 1 ):
		
		if (  Input.is_action_just_pressed("mouse_btn_left") ):
			
			allRect = Rect2(mXG-32, mYG-32, 32, 32 );
			mouse_tex = ImageTexture.create_from_image(image.texture.get_image().get_region( allRect ) );
			selectRect = Rect2(mXG-16, mYG-16, 32, 32 );
			mouseGroup.Fnum.clear();
		
	elif ( imageEnter == 2):
		if ( Input.is_action_pressed("mouse_btn_left")  && imageEnter == 2 ):
			#canvasTex[ mGpos + Vector2(-16, -16) ] = mouse_tex;
			for i in range (0, mouseGroup.Fnum.size() ):
				canvasTex[ mGpos + Vector2( -16,-16 ) + mouseGroup.Fnum[i].cords ] = mouseGroup.Fnum[i].img;
			
			
			
			#canvasTex[ mGpos + Vector2(-16, -16) ] = mouse_tex;
			#draw_texture( mouseGroup.Fnum[i].img, mGpos + Vector2( -16,-16 ) + mouseGroup.Fnum[i].cords  );
		
		elif ( Input.is_action_pressed("mouse_btn_right")  && imageEnter == 2 ):
			canvasTex.erase( mGpos + Vector2(-16, -16)  )
		
		
		
		
	
	
	queue_redraw();




func _draw():
	
	
	#-image_grid
	for i in range( 19 ): # Rows
		var ia = i*32;
		draw_line(Vector2( grid1X , grid1Y+ia ), Vector2( grid1W, grid1Y+ia ), Color(1, 1, 1, 0.2 ) , 1); #horizontal
	for i in range( 24 ): # Columns
		var ia = i*32;
		
		draw_line(Vector2( grid1X+ia , grid1Y ), Vector2( grid1X+ia, grid1H ), Color(1, 1, 1, 0.2 ) , 1); #horizontal
	
	
	#-drawingCanvas_grid
	for i in range( 19 ): # Rows
		var ia = i*32;
		draw_line(Vector2( 32*24+16 , grid1Y+ia ), Vector2( 32*39+16, grid1Y+ia ), Color(1, 1, 1, 0.5 ) , 1); #horizontal
	for i in range( 16 ): # Columns
		var ia = i*32;
		
		draw_line(Vector2( 32*24+16+ia , grid1Y ), Vector2( 32*24+16+ia, grid1H ), Color(1, 1, 1, 0.5 ) , 1); #horizontal
	
	
	
	
	draw_string(font, mGpos + Vector2(-32, 32) , "mPOS: " + str( mGpos ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE );
	
	
	
	if ( imageEnter == 1 ):
		draw_rect(Rect2(mXG-16, mYG-16, 32, 32 ), Color.YELLOW, false, 2 );
	elif ( imageEnter == 2 ):
		draw_rect(Rect2(mXG-16, mYG-16, selectRect.size.x, selectRect.size.y ), Color.BLUE, false, 2 );
	
	
	
	
	draw_rect( selectRect, Color.YELLOW, false, 2 );
	
	
	for i in canvasTex: 
		
		draw_texture( canvasTex[i], i );
		
	
	
	if ( Input.is_action_pressed("left_crt") ):
		
		for i in range (0, mouseGroup.Fnum.size() ):
		
			draw_texture( mouseGroup.Fnum[i].img, mGpos + Vector2( -16,-16 ) + mouseGroup.Fnum[i].cords  );
			
			print(mouseGroup.Fnum.size())
		
	
	
	
	









