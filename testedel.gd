extends TextureRect


var image = texture;
var font = ThemeDB.fallback_font;
var mouse_OnImage = false;

var mX = 0; # mouse select X
var mY = 0; # mouse select Y
var mW = 0; # mouse select weight
var mH = 0; # mouse select height


var selectionVIEW = Rect2(0, 0, 1, 1 ); # keeps the tiles selection onscreen

var allRect = Rect2(0, 0, 32, 32 ); # all draw Rect2 region / selection coords will go in here / its better to initialize with something, or it will throw 3 error's texture null
var mouse_tex = ImageTexture.create_from_image(texture.get_image().get_region( allRect ) ); # the texture that goes into the mouse sprite node

@onready var mouseSpriteNode = get_node_or_null("../mouseSprite"); #.. gets the other node in the scene "mouseSprite"
@onready var mouseSpriteNode2 = get_node_or_null("../view/port/mouseSprite2");


var click_pos: Array = [];



func _ready():
	##... its better to inizialize the mouseSprite node with some texture...
	##... mouseSprite doesnt draw...it only shows the user the image of what he is drawing...
	if ( mouseSpriteNode != null ):
		mouseSpriteNode.texture = mouse_tex;
		
		
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	
	






func _process(_delta):
	
	
	
	if ( mouse_OnImage == false && Input.is_action_pressed("mouse_btn_left") ):
		
		
		click_pos.append( Vector2 (   snapped(  get_local_mouse_position().x, 32 ), snapped(get_local_mouse_position().y, 32 )   )    );
		
		
		queue_redraw();
		
		
	
	if ( mouse_OnImage == true ):
		
		
		if ( ! Input.is_action_pressed("mouse_btn_left")  ):
			
			pass;
		
		if ( Input.is_action_just_pressed("mouse_btn_left")  ):
			
			mX = snapped(get_local_mouse_position().x, 32 );
			mY = snapped(get_local_mouse_position().y, 32 );
			
			selectionVIEW = Rect2(0, 0, 0, 0 );  
		
		
		elif ( Input.is_action_pressed("mouse_btn_left")  ):
			
			mW = snapped(get_local_mouse_position().x - mX, 32 );
			mH = snapped(get_local_mouse_position().y - mY, 32 );
			
			if ( mW == 0 || mH == 0 ):
				allRect = Rect2( mX, mY, abs(mW)+32, abs(mH)+32 );
				
			else:
				
				allRect = Rect2( mX, mY, mW+32, mH+32 );
				
			if ( mW < 0 && mH < 0 ):
				var mAA = snapped(get_local_mouse_position().x, 32 );
				var mBB = snapped(get_local_mouse_position().y, 32 );
				allRect = Rect2( mAA, mBB, abs(mW)+32, abs(mH)+32 );
				
			elif ( mW < 0 && mH > 0 ):
				var mAA = snapped(get_local_mouse_position().x, 32 );
				allRect = Rect2( mAA, mY, abs(mW)+32, mH+32 );
				
			elif ( mW > 0 && mH < 0 ):
				var mBB = snapped(get_local_mouse_position().y, 32 );
				allRect = Rect2( mX, mBB, mW, abs(mH)+32 );
				
			else:
				allRect = Rect2( mX, mY, mW+32, mH+32 );
				
			
			
			
		elif ( Input.is_action_just_released("mouse_btn_left")  ):
			
			#... The sprite that follows the mouse gets its new texture
			mouse_tex = ImageTexture.create_from_image(texture.get_image().get_region( allRect ) );
			mouseSpriteNode.texture = mouse_tex;
			
			
			selectionVIEW = allRect;
			
			
			
			
			
		
		queue_redraw();
		
	
	
	





var textures = {};

func _draw():
	
	#draw_texture_rect_region(image, Rect2(800, 10, 50, 50), Rect2(40, 40, 50, 50) );
	
	#draw_texture_rect_region(image, Rect2(32*25, 32*3, 32*2, 32*2), Rect2(32*5, 32*3, 32*2, 32*2) );
	#draw_texture_rect_region(image, Rect2(32*28, 32*3, 32*2, 32*2), Rect2(32*5, 32*3, 32*2, 32*2) );
	####################################-posi-to-draw-##-size-w-h-########-img-rect-posi-##-size-w-h-###
	
	
	
	
	
	
	
	if ( mouse_OnImage == false && Input.is_action_pressed("mouse_btn_left") ):
		
		#################...TILE..TRANSPARENCY..PROBLEMS...#####.."TRANSPARENCY.GOES.DARKER"...###########
		
		##########...this turns the tile into a brush, the "TRANSPARENCY.GOES.DARKER"..currently OFF...#######
		#textures[ get_local_mouse_position() ] = mouse_tex;
		
		#------------------//-----------//-----------//-------------------
		
		###...this turns the tile into a normal tile 32x32, but anything bigger than 32 "TRANSPARENCY.GOES.DARKER"..!!!
		
		#var a1 = snapped(get_local_mouse_position().x, 32);
		#var a2 = snapped(get_local_mouse_position().y, 32);
		#textures[ Vector2( a1,a2 ) ] = mouse_tex;
		
		
		
		##############---everyThing-working-has-intended--EXCEPT-FOR:                     ################
		#########---vars snap1/2,mouseSpriteNode.snapM1x needs to be outside is-action-pressed ###########
		########--dictionary- var textures = {} is not store a snap position // target inaccurate ########
		######--INCOMPLETE 32x32 needs to be in a var ? TILE SIZE ?, the same for tile width/height ######
		######-- there are already 2 vars being drawn on screen (line232 ) contains coords and tileSize ##
		
		var snap1 = mouse_tex.get_width();
		var snap2 = mouse_tex.get_height();
		
		mouseSpriteNode.snapM1x = snap1;
		mouseSpriteNode.snapM1y = snap2;
		
		var b1 = snapped(get_local_mouse_position().x, snap1);
		var b2 = snapped(get_local_mouse_position().y, snap2);
		
		
		textures[ Vector2( b1,b2 ) ] = mouse_tex;
		
		
	
	
	#####################################################################################
	######################## THIS DRAWS EVERYTHING ON SCREEN ############################
	
	#for index in click_pos.size():
	#	draw_texture(mouse_tex, click_pos[index] );
	
	for key in textures: 
		var tex_to_draw = textures[key];
		
		draw_texture( tex_to_draw, Vector2(  snapped(key.x, 32) , snapped(key.y, 32)  )  );
		
		#print( textures.size() )
		
	
	#####################################################################################
	#####################################################################################
	
	
	
	
	
	
	
	###########################################################################################
	#########..all of the drawing is done here // !! WAS BEING DONE HERE !! ################
	if ( mouse_OnImage == false && Input.is_action_just_pressed("mouse_btn_left") ):
		
		#### when the image scale set to 0.5... this needs to be *2 ( 0.5*2 = 1 ) ###################
		#var sclx = scale.x * 2;
		#var scly = scale.y * 2;
		
		#draw_texture_rect_region(image, Rect2(snapped(get_local_mouse_position().x, 32 * sclx ), snapped(get_local_mouse_position().y, 32 * scly), allRect.size.x * sclx, allRect.size.y * scly   ), allRect );
		
		
		
		
		
		pass;
	
	###########################################################################################
	###########################################################################################
	
	
	
	
	###############################---DRAWS-THE-GRID---###################################################
	for i in range(0, texture.get_height() +1, 32): # horizontal line
		draw_line(Vector2(0,i), Vector2( texture.get_width()  ,i), Color.CADET_BLUE , 1);
		pass;
	
	for i in range(0, texture.get_width() +1, 32): # vertical line
		draw_line(Vector2(i,0), Vector2(i, texture.get_height()  ), Color.CADET_BLUE, 1);
	######################################################################################################
	
	
	if ( mouse_OnImage == true ):
		
		### draw the allRect Rect2 things  x y width heigh ( position(mouse) and area(width,height) )
		draw_string(font, Vector2( get_local_mouse_position().x+15, get_local_mouse_position().y-30 ) , "mousePOSI: " + str( Vector2( snapped(mX, 32 ) , snapped(mY, 32 ) )   ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color.YELLOW );
		draw_string(font, Vector2( get_local_mouse_position().x+15, get_local_mouse_position().y-15 ) , "mouseAREA: " + str( Vector2( snapped(mW, 32 ) , snapped(mH, 32 ) )   ) , HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color.YELLOW );
		
		
		if ( ! Input.is_action_pressed("mouse_btn_left")  ):
			# Keeps the cursor in STANDARD TILE size 32*32....... when nothing is pressed
			draw_rect(Rect2( snapped(get_local_mouse_position().x, 32 ), snapped(get_local_mouse_position().y, 32), 32, 32), Color.YELLOW, false, 2 );
			draw_rect(Rect2( snapped(get_local_mouse_position().x, 32 ), snapped(get_local_mouse_position().y, 32), 32, 32), Color.YELLOW, false, 2 );
			
			
		
		if ( Input.is_action_just_pressed("mouse_btn_left")  ):
			
			mX = snapped(get_local_mouse_position().x, 32 );
			mY = snapped(get_local_mouse_position().y, 32 );
			
			#..selectionVIEW = Rect2(0, 0, 0, 0 )..STANDARD TILE selecion is out from the view... 
			#..or 2 squares will be showing when dragging the mouse..
			selectionVIEW = Rect2(0, 0, 0, 0 );  
		
		
		
		
		
		
		elif ( Input.is_action_pressed("mouse_btn_left")  ):
			
			mW = snapped(get_local_mouse_position().x - mX, 32 );
			mH = snapped(get_local_mouse_position().y - mY, 32 );
			
			#... all this if else elif writen below... 
			#... makes the selection possible..from all diferent directions.. 
			#... when draggin left mW(mouseWidth) is negative... when draggin up mH(mouseHeight) is negative...  
			
			if ( mW == 0 || mH == 0 ):
				allRect = Rect2( mX, mY, abs(mW)+32, abs(mH)+32 );
				
			else:
				
				allRect = Rect2( mX, mY, mW+32, mH+32 );
				
			if ( mW < 0 && mH < 0 ):
				var mAA = snapped(get_local_mouse_position().x, 32 );
				var mBB = snapped(get_local_mouse_position().y, 32 );
				allRect = Rect2( mAA, mBB, abs(mW)+32, abs(mH)+32 );
				
			elif ( mW < 0 && mH > 0 ):
				var mAA = snapped(get_local_mouse_position().x, 32 );
				allRect = Rect2( mAA, mY, abs(mW)+32, mH+32 );
				
			elif ( mW > 0 && mH < 0 ):
				var mBB = snapped(get_local_mouse_position().y, 32 );
				allRect = Rect2( mX, mBB, mW, abs(mH)+32 );
				
			else:
				allRect = Rect2( mX, mY, mW+32, mH+32 );
				
			
			
			#... Draws the above allRect into a selection
			draw_rect( allRect, Color.YELLOW, false, 2 );
			
			
			
		elif ( Input.is_action_just_released("mouse_btn_left")  ):
			
			#... The sprite that follows the mouse gets its new texture "mouse_tex"
			mouse_tex = ImageTexture.create_from_image(texture.get_image().get_region( allRect ) );
			mouseSpriteNode.texture = mouse_tex;
			
			selectionVIEW = allRect;
			
			
	
	
	##.. its writen above... "selectionVIEW = allRect;"
	##.. once tile selection is made...the selection stays on screen... 
	##.. its easier on the user's eyes, and commom in all tileSet editor's...
	draw_rect( selectionVIEW, Color.YELLOW, false, 2 );
	
	






func _on_mouse_entered():
	mouse_OnImage = true;
	mouseSpriteNode.visible = false;
	if ( Input.is_action_pressed("mouse_btn_left")  ):
		warp_mouse( Vector2(mX, mY) );



func _on_mouse_exited():
	mouse_OnImage = false;
	mouseSpriteNode.visible = true;
	queue_redraw(); # just to get the mouse coords out of the screen 

