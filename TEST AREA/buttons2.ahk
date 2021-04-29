#SingleInstance,Force
SetBatchLines,-1
Gdip_Startup()

Gui,1:+AlwaysOnTop -DPIScale
Gui,1:Color,% Background_Color:="aaaaaa",222222
Gui,1:Font,cWhite s10 Bold,Arial

;#########################################################################################################
;#########################################################################################################
;New Switch Prototype
;~ Always:=New Sunken_Dark_Switch_1(x:=10, y:=10, w:=70, window:="1", Label:="", State:=1, Background_Color:="333333", Text:="", Font:="Arial", Font_Size:="10 Bold", Font_Color:="FFFFFF", Y_Offset:="")
;#########################################################################################################
;#########################################################################################################
Always:=New Sunken_Dark_Switch_1(x:=10
							   , y:=15
							   , w:=170
							   , window:="1"
							   , Label:="AlwaysOnTop"
							   , State:=1
							   , Background_Color
							   , Text:="AlwaysOnTop"
							   , Font:="Arial"
							   , Font_Size:="12 Bold"
							   , Font_Color:="000000"
							   , Y_Offset:="0")
;#########################################################################################################
;#########################################################################################################

global Option:=New Sunken_Dark_Switch_1(x:=10, y:=60, w:=170, window:="1", Label:="Some_Function", State:=0, Background_Color, Text:="Play Sounds", Font:="Segoe UI", Font_Size:="12 Bold", Font_Color:="ff0000", Y_Offset:="")


;******************************************************
;******************************************************
;Adding some buttons for the hell of it
global HB_Button:=[]

HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x:=10  , y:=210 , w:=280  , h := 30 , Button_Color := "22005C" , Button_Background_Color, Text := "Some Random Button That Does Nothing" , Font := "Arial" , Font_Size := 10 " Bold" , Font_Color_Top := "aaaaaa" , Font_Color_Bottom := "000000" , Window := "1" , Label := "SomeBSLabel" , Default_Button := 0 , Roundness:=2 ) )

;******************************************************
;******************************************************


Gui,1:Show,% "x" A_ScreenWidth-350 " y100 w300 h250 NA", Sunken Dark Switch Class



SetTimer, HB_Button_Hover , 50  ;Button hover timer (Not related to the switch class)
return
GuiClose:
GuiContextMenu:
*Esc::
	ExitApp
	
AlwaysOnTop:
	if(Always.State=1)
		Gui,1:+AlwaysOnTop
	else
		Gui,1:-AlwaysOnTop
	return

Some_Function(){
	hz:=300
	if(Option.State){
		Loop 3
			SoundBeep,hz+=100
	}else 	{
		Traytip,,No Sounds For You!
	}
}





class Sunken_Dark_Switch_1	{
	__New(x:=10, y:=10, w:=70, window:="1", Label:="", State:=1, Background_Color:="333333", Text:="", Font:="Arial", Font_Size:="10 Bold", Font_Color:="FFFFFF", Y_Offset:="0"){
		This.X:=x,This.Y:=y,This.W:=w,This.H:=30,This.Window:=window,This.Label:=Label,This.State:=State
		This.Background_Color:="0xFF" Background_Color,This.Text:=Text,This.Font:=Font
		This.Font_Color:="0xFF" Font_Color,This.Font_Size:=Font_Size,This.Y_Offset:=y_Offset
		This._Create_Trigger(),This._Create_Off_Bitmap(),This._Create_On_Bitmap()
		sleep, 20
		(This.State=1)?(This._Draw_On()):(This._Draw_Off())
	}
	_Create_Trigger(){
		local hwnd
		Gui,% This.Window ":Add",Picture,% "x" This.X " y" This.Y " w" This.W " h" This.H " hwndhwnd 0xE"
		This.Hwnd:=hwnd
		BP:=This._Switch_States.Bind(This)
		GuiControl,% This.Window ":+G",% This.Hwnd,% BP
		if(This.Label)
			(isFunc(This.Label))?(This.Function:=Func(This.Label))
	}
	_Create_Off_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , This.H )
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 4 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+3 , This.H+3 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF555555" )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 26 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 3 , 64 , 24 , "0xFF151515" , "0xFF222222" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 4 , 67 , 28 , "0x88000000" , "0x88222222" , 3 , 3 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 3 , 64 , 24 , "0xFF252525" , "0xFF222222" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 4 , 5 , 62 , 19 , 7 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 4 , 67 , 28 , "0x88000000" , "0x88222222" , 3 , 3 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 4 , 67 , 28 , "0x44000000" , "0x44222222" , 3 , 3 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF000000" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 30 , 25 , "0xFF222222" , "0xFF151515" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 35 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 4 , 28 , 24 , "0xaa373737" , "0xaa222222" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 3 , 3 , 32 , 23 , 5 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF000000" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 2 , 2 , 34 , 25 , 5 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x665F5F5F" , 2 )
		Gdip_DrawLine( G , Pen , 9 , 11 , 30 , 11 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xff202020" , 1 )
		Gdip_DrawLine( G , Pen , 9 , 12 , 30 , 12 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x665F5F5F" , 2 )
		Gdip_DrawLine( G , Pen , 9 , 15 , 30 , 15 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xff202020" , 1 )
		Gdip_DrawLine( G , Pen , 9 , 16 , 30 , 16 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x665F5F5F" , 2 )
		Gdip_DrawLine( G , Pen , 9 , 19 , 30 , 19 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xff1a1a1a" , 1 )
		Gdip_DrawLine( G , Pen , 9 , 21 , 30 , 21 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "OFF" , "s12 Center vCenter Bold c" Brush " x27 y1" , "Arial" , 50 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFFF0F0F0" )
		Gdip_TextToGraphics( G , "OFF" , "s12 Center vCenter Bold c" Brush " x27 y2" , "Arial" , 50 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " vCenter c" Brush " x75 y" 2+This.Y_Offset , This.Font , This.W-75 , This.H )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Switch_Off_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_On_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , This.H )
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 4 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+3 , This.H+3 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF555555" )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 26 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 3 , 64 , 24 , "0xFF151515" , "0xFF222222" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 4 , 67 , 28 , "0x88000000" , "0x88222222" , 3 , 3 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 3 , 64 , 24 , "0xFF252525" , "0xFF222222" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 4 , 5 , 62 , 19 , 7 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 4 , 67 , 28 , "0x88000000" , "0x88222222" , 3 , 3 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 4 , 67 , 28 , "0x44000000" , "0x44222222" , 3 , 3 )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF000000" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 2 , 2 , 66 , 25 , 5 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 30 , 25 , "0xFF222222" , "0xFF151515" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 33 , 2 , 35 , 25 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 4 , 28 , 24 , "0xaa373737" , "0xaa222222" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 35 , 3 , 32 , 23 , 5 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF000000" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 34 , 2 , 34 , 25 , 5 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x665F5F5F" , 2 )
		Gdip_DrawLine( G , Pen , 42 , 11 , 63 , 11 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xff202020" , 1 )
		Gdip_DrawLine( G , Pen , 42 , 12 , 63 , 12 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x665F5F5F" , 2 )
		Gdip_DrawLine( G , Pen , 42 , 15 , 63 , 15 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xff202020" , 1 )
		Gdip_DrawLine( G , Pen , 42 , 16 , 63 , 16 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x665F5F5F" , 2 )
		Gdip_DrawLine( G , Pen , 42 , 19 , 63 , 19 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xff1a1a1a" , 1 )
		Gdip_DrawLine( G , Pen , 42 , 21 , 63 , 21 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "ON" , "s12 Center vCenter Bold c" Brush " x-9 y1" , "Arial" , 50 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFFF0F0F0" )
		Gdip_TextToGraphics( G , "ON" , "s12 Center vCenter Bold c" Brush " x-8 y2" , "Arial" , 50 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " vCenter c" Brush " x75 y" 2+This.Y_Offset , This.Font , This.W-75 , This.H )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Switch_On_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Switch_States(){
		GuiControl,% This.Window ":Focus",% This.Hwnd
		(This.State=1)?(This.State:=0,This._Draw_Off()):(This.State:=1,This._Draw_On())
		if(This.Label){
			if(This.Function)
				This.Function.Call()
			else
				gosub,% This.Label
		}
	}
	_Draw_Off(){
		SetImage(This.Hwnd,This.Switch_Off_Bitmap)
	}
	_Draw_On(){
		SetImage(This.Hwnd,This.Switch_On_Bitmap)
	}
}














; Everything below this line is unrelated to the switch class
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%












SomeBSLabel:
	GuiControl , % HB_Button[ A_GuiControl ].Window ": Focus" , % HB_Button[ A_GuiControl ].Hwnd
	if( ! HB_Button[ A_GuiControl ].Draw_Pressed() )
		return
	Traytip,, This is utter BS
	return




HB_Button_Hover(){
	Static Index , Hover_On
	MouseGetPos,,,, ctrl , 2
	if( ! Hover_On && ctrl ){
		loop , % HB_Button.Length()
			if( ctrl = HB_Button[ A_Index ].hwnd )
				HB_Button[ A_Index ].Draw_Hover() , Index := A_Index , Hover_On := 1 , break
	}else if( Hover_On = 1 )
		if( ctrl != HB_Button[ Index ].Hwnd )
			HB_Button[ Index ].Draw_Default() , Hover_On := 0
}
class HB_Flat_Rounded_Button_Type_1	{
	__New( x := 10 , y := 10 , w := 150 , h := 40 , Button_Color := "FF0000" , Button_Background_Color := "222222" , Text := "Button" , Font := "Arial" , Font_Size := 16 , Font_Color_Top := "000000" , Font_Color_Bottom := "FFFFFF" , Window := "1" , Label := "" , Default_Button := 1, Roundness:=5 ){
		This.Roundness:=Roundness,This.Text_Color_Top := "0xFF" Font_Color_Top,This.Text_Color_Bottom := "0xFF" Font_Color_Bottom,This.Font := Font 
		This.Font_Size := Font_Size,This.Text := Text,This.X:=x,This.Y:=y,This.W := w,This.H := h 
		This.Button_Background_Color := "0xFF" Button_Background_Color,This.Button_Color := "0xFF" Button_Color,This.Window := Window,This.Label := Label 
		This.Default_Button := Default_Button,This.Create_Default_Bitmap(),This.Create_Hover_Bitmap(),This.Create_Pressed_Bitmap(),This.Create_Trigger()
		sleep, 20
		This.Draw_Default()
	}
	Create_Trigger(){
		global
		num := HB_Button.Length()+1
		Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " hwndHwnd v" Num " g" This.Label " 0xE"
		This.Number := Num , This.Hwnd := Hwnd
	}
	Create_Default_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , This.H )
		 G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 2 )
		Brush := Gdip_BrushCreateSolid( This.Button_Background_Color )
		Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , This.H+2 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF61646A" , "0xFF2E2124" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 0 , 1 , This.W , This.H-3 , This.Roundness )
		Gdip_DeleteBrush( Brush )
		if(This.Default_Button)
			Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF4C4F54" , "0xFF35373B" , 1 , 1 )
		else 	
			Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , This.Button_Color , "0xFF222222" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , This.W-2 , This.H-5 , This.Roundness )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF000000" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W-1 , This.H-3 , This.Roundness )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( This.Text_Color_Bottom )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y2 " , This.Font , This.W , This.H-1 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Text_Color_Top )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y1 " , This.Font , This.W , This.H-1 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Default_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	Create_Hover_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , This.H )
		 G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 2 )
		Brush := Gdip_BrushCreateSolid( This.Button_Background_Color )
		Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , This.H+2 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF61646A" , "0xFF2E2124" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 0 , 1 , This.W , This.H-3 , This.Roundness )
		Gdip_DeleteBrush( Brush )
		if(This.Default_Button)
			Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF55585D" , "0xFF3B3E41" , 1 , 1 )
		else 
			Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xff620096" , "0xFF333333" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , This.W-2 , This.H-5 , This.Roundness )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W-1 , This.H-3 , This.Roundness )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( This.Text_Color_Bottom )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y2" , This.Font , This.W , This.H-1 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Text_Color_Top )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y1" , This.Font , This.W , This.H-1 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Hover_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	Create_Pressed_Bitmap(){
		pBitmap:=Gdip_CreateBitmap( This.W , This.H )
		 G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 2 )
		Brush := Gdip_BrushCreateSolid( This.Button_Background_Color )
		Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , This.H+2 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF2A2C2E" , "0xFF45474E" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 0 , 1 , This.W , This.H-3 , This.Roundness )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF2A2C2E" )
		Gdip_FillRoundedRectangle( G , Brush , 0 , 0 , This.W , This.H-8 , This.Roundness )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF46474D" )
		Gdip_FillRoundedRectangle( G , Brush , 0 , 7 , This.W , This.H-8 , This.Roundness )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , This.W ,This.H-7 , "0xFF111111" , "0xFF610094" , 1 , 1 )
		Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , This.W-3 , This.H-6 , This.Roundness )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W-1 , This.H-3 , This.Roundness )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( This.Text_Color_Bottom )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y3" , This.Font , This.W , This.H-1 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Text_Color_Top )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y2" , This.Font , This.W , This.H-1 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Pressed_Bitmap := Gdip_CreateHBITMAPFromBitmap( pBitmap )
		Gdip_DisposeImage( pBitmap )
	}
	Draw_Default(){
		SetImage( This.Hwnd , This.Default_Bitmap )
	}
	Draw_Hover(){
		SetImage( This.Hwnd , This.Hover_Bitmap )
	}
	Draw_Pressed(){
		SetImage( This.Hwnd , This.Pressed_Bitmap )
		SetTimer , HB_Button_Hover , Off
		While( GetKeyState( "LButton" ) )
			sleep , 10
		SetTimer , HB_Button_Hover , On
		MouseGetPos,,,, ctrl , 2
		if( This.Hwnd != ctrl ){
			This.Draw_Default()
			return False
		}else	{
			This.Draw_Hover()
			return true
		}
	}
}





















;######################################################################################################################################
;#####################################################   					    #######################################################
;#####################################################  	  Gdip LITE		    #######################################################
;#####################################################  					    #######################################################
;######################################################################################################################################
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster=""){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdi32\BitBlt", Ptr, dDC, "int", dx, "int", dy, "int", dw, "int", dh, Ptr, sDC, "int", sx, "int", sy, "uint", Raster ? Raster : 0x00CC0020)
}
Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
	if(sx = "" && sy = "" && sw = "" && sh = ""){
		if(dx = "" && dy = "" && dw = "" && dh = ""){
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}else	{
			sx := sy := 0,sw := Gdip_GetImageWidth(pBitmap),sh := Gdip_GetImageHeight(pBitmap)
		}
	}
	E := DllCall("gdiplus\GdipDrawImageRectRect", Ptr, pGraphics, Ptr, pBitmap, "float", dx, "float", dy, "float", dw, "float", dh, "float", sx, "float", sy, "float", sw, "float", sh, "int", 2, Ptr, ImageAttr, Ptr, 0, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}
Gdip_SetImageAttributesColorMatrix(Matrix){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", "", 1), "[^\d-\.]+", "|")
	StringSplit, Matrix, Matrix, |
	Loop, 25
	{
		Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
	return ImageAttr
}
Gdip_GetImageWidth(pBitmap){
   DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
   return Width
}
Gdip_GetImageHeight(pBitmap){
   DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
   return Height
}
Gdip_DeletePen(pPen){
   return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}
Gdip_DeleteBrush(pBrush){
   return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}
Gdip_DisposeImage(pBitmap){
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}
Gdip_DeleteGraphics(pGraphics){
   return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
Gdip_DisposeImageAttributes(ImageAttr){
	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}
Gdip_DeleteFont(hFont){
   return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
}
Gdip_DeleteStringFormat(hFormat){
   return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
}
Gdip_DeleteFontFamily(hFamily){
   return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
}
CreateCompatibleDC(hdc=0){
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
SelectObject(hdc, hgdiobj){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}
DeleteObject(hObject){
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}
GetDC(hwnd=0){
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}
GetDCEx(hwnd, flags=0, hrgnClip=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}
ReleaseDC(hdc, hwnd=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}
DeleteDC(hdc){
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
Gdip_SetClipRegion(pGraphics, Region, CombineMode=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
}
CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)
	NumPut(w, bi, 4, "uint"), NumPut(h, bi, 8, "uint"), NumPut(40, bi, 0, "uint"), NumPut(1, bi, 12, "ushort"), NumPut(0, bi, 16, "uInt"), NumPut(bpp, bi, 14, "ushort")
	hbm := DllCall("CreateDIBSection", Ptr, hdc2, Ptr, &bi, "uint", 0, A_PtrSize ? "UPtr*" : "uint*", ppvBits, Ptr, 0, "uint", 0, Ptr)
	if !hdc
		ReleaseDC(hdc2)
	return hbm
}
Gdip_GraphicsFromImage(pBitmap){
	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}
Gdip_GraphicsFromHDC(hdc){
    DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
    return pGraphics
}
Gdip_GetDC(pGraphics){
	DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
	return hdc
}


Gdip_Startup(){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}
Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0){
	IWidth := Width, IHeight:= Height
	RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
	RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
	RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
	RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
	RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
	RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
	RegExMatch(Options, "i)NoWrap", NoWrap)
	RegExMatch(Options, "i)R(\d)", Rendering)
	RegExMatch(Options, "i)S(\d+)(p*)", Size)
	if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
		PassBrush := 1, pBrush := Colour2
	if !(IWidth && IHeight) && (xpos2 || ypos2 || Width2 || Height2 || Size2)
		return -1
	Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
	Loop, Parse, Styles, |
	{
		if RegExMatch(Options, "\b" A_loopField)
		Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
	}
	Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
	Loop, Parse, Alignments, |
	{
		if RegExMatch(Options, "\b" A_loopField)
			Align |= A_Index//2.1      ; 0|0|1|1|2|2
	}
	xpos := (xpos1 != "") ? xpos2 ? IWidth*(xpos1/100) : xpos1 : 0
	ypos := (ypos1 != "") ? ypos2 ? IHeight*(ypos1/100) : ypos1 : 0
	Width := Width1 ? Width2 ? IWidth*(Width1/100) : Width1 : IWidth
	Height := Height1 ? Height2 ? IHeight*(Height1/100) : Height1 : IHeight
	if !PassBrush
		Colour := "0x" (Colour2 ? Colour2 : "ff000000")
	Rendering := ((Rendering1 >= 0) && (Rendering1 <= 5)) ? Rendering1 : 4
	Size := (Size1 > 0) ? Size2 ? IHeight*(Size1/100) : Size1 : 12
	hFamily := Gdip_FontFamilyCreate(Font)
	hFont := Gdip_FontCreate(hFamily, Size, Style)
	FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
	hFormat := Gdip_StringFormatCreate(FormatStyle)
	pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
	if !(hFamily && hFont && hFormat && pBrush && pGraphics)
		return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0
	CreateRectF(RC, xpos, ypos, Width, Height)
	Gdip_SetStringFormatAlign(hFormat, Align)
	Gdip_SetTextRenderingHint(pGraphics, Rendering)
	ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	if vPos
	{
		StringSplit, ReturnRC, ReturnRC, |
		if (vPos = "vCentre") || (vPos = "vCenter")
			ypos += (Height-ReturnRC4)//2
		else if (vPos = "Top") || (vPos = "Up")
			ypos := 0
		else if (vPos = "Bottom") || (vPos = "Down")
			ypos := Height-ReturnRC4
		CreateRectF(RC, xpos, ypos, Width, ReturnRC4)
		ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	}
	if !Measure
		E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)
	if !PassBrush
		Gdip_DeleteBrush(pBrush)
	Gdip_DeleteStringFormat(hFormat)
	Gdip_DeleteFont(hFont)
	Gdip_DeleteFontFamily(hFamily)
	return E ? E : ReturnRC
}
Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	return DllCall("gdiplus\GdipDrawString", Ptr, pGraphics, Ptr, A_IsUnicode ? &sString : &wString, "int", -1, Ptr, hFont, Ptr, &RectF, Ptr, hFormat, Ptr, pBrush)
}
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
	DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1){
	CreateRectF(RectF, x, y, w, h)
	DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}
Gdip_CloneBrush(pBrush){
	DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
	return pBrushClone
}
Gdip_FontFamilyCreate(Font){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wFont, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
	}
	DllCall("gdiplus\GdipCreateFontFamilyFromName", Ptr, A_IsUnicode ? &Font : &wFont, "uint", 0, A_PtrSize ? "UPtr*" : "UInt*", hFamily)
	return hFamily
}
Gdip_SetStringFormatAlign(hFormat, Align){
   return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
}
Gdip_StringFormatCreate(Format=0, Lang=0){
   DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
   return hFormat
}
Gdip_FontCreate(hFamily, Size, Style=0){
   DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
   return hFont
}
Gdip_CreatePen(ARGB, w){
   DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
   return pPen
}
Gdip_CreatePenFromBrush(pBrush, w){
	DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
	return pPen
}
Gdip_BrushCreateSolid(ARGB=0xff000000){
	DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle=0){
	DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}
CreateRectF(ByRef RectF, x, y, w, h){
   VarSetCapacity(RectF, 16)
   NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
}
Gdip_SetTextRenderingHint(pGraphics, RenderingHint){
	return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
}
Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	VarSetCapacity(RC, 16)
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	DllCall("gdiplus\GdipMeasureString", Ptr, pGraphics, Ptr, A_IsUnicode ? &sString : &wString, "int", -1, Ptr, hFont, Ptr, &RectF, Ptr, hFormat, Ptr, &RC, "uint*", Chars, "uint*", Lines)
	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}
CreateRect(ByRef Rect, x, y, w, h){
	VarSetCapacity(Rect, 16)
	NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
CreateSizeF(ByRef SizeF, w, h){
   VarSetCapacity(SizeF, 8)
   NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")
}
CreatePointF(ByRef PointF, x, y){
   VarSetCapacity(PointF, 8)
   NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")
}
Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawArc", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}
Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawPie", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}
Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawLine", Ptr, pGraphics, Ptr, pPen, "float", x1, "float", y1, "float", x2, "float", y2)
}
Gdip_DrawLines(pGraphics, pPen, Points){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipDrawLines", Ptr, pGraphics, Ptr, pPen, Ptr, &PointF, "int", Points0)
}
Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillRectangle", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}
Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r){
	Region := Gdip_GetClipRegion(pGraphics)
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_DeleteRegion(Region)
	return E
}
Gdip_GetClipRegion(pGraphics){
	Region := Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt*", Region)
	return Region
}
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0){
   return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}
Gdip_SetClipPath(pGraphics, Path, CombineMode=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, Path, "int", CombineMode)
}
Gdip_ResetClip(pGraphics){
   return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}
Gdip_FillRegion(pGraphics, pBrush, Region){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
}
Gdip_FillPath(pGraphics, pBrush, Path){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, Path)
}
Gdip_CreateRegion(){
	DllCall("gdiplus\GdipCreateRegion", "UInt*", Region)
	return Region
}
Gdip_DeleteRegion(Region){
	return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
}
Gdip_CreateBitmap(Width, Height, Format=0x26200A){
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
    Return pBitmap
}
Gdip_SetSmoothingMode(pGraphics, SmoothingMode){
   return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}
Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}
Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r){
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
	Gdip_ResetClip(pGraphics)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_ResetClip(pGraphics)
	return E
}
Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawEllipse", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}
Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff){
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
	return hbm
}
SetImage(hwnd, hBitmap){
	SendMessage, 0x172, 0x0, hBitmap,, ahk_id %hwnd%
	E := ErrorLevel
	DeleteObject(E)
	return E
}
Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipFillPolygon", Ptr, pGraphics, Ptr, pBrush, Ptr, &PointF, "int", Points0, "int", FillMode)
}