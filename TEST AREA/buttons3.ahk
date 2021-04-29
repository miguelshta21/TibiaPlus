;***************************************************************************************************
;***************************************************************************************************
;***************************************************************************************************


;***************************************************************************************************
;***************************************************************************************************
;***************************************************************************************************



;##################################################################################################################################################
;##################################################################################################################################################

; Written By: Hellbent aka CivReborn (https://www.youtube.com/user/CivReborn)
; Date Started: March 1st, 2019
; Date of Last Edit: March 29th, 2020
; Current Version: v0.1.8 Early Alpha 
; Credits: Speed Master , 

; Updates: v0.1.8 - March 29th, 2020
;---------------------------------------------------------------------------------------------------------------
; Element Listbox now shows if a element has a note attached to it.
; Gdip library removed from the script, user must now #Include it.

; Updates: v0.1.7 - June 6th, 2019
;---------------------------------------------------------------------------------------------------------------
; Fixed major memory leak
; Added Refactored code submitted by - Speed Master
; Added Extra Hotkeys Submitted by - Speed Master
; Added Save progress bar to Save tab, can now see the save progress.
; Removed +AlwaysOnTop Option.
; Added CREDITS DDL to tab 6.
; Other small changes.


; Updates: v0.1.5
;---------------------------------------------------------------------------------------------------------------
; Fill_poygon Added.
; Draw_Lines Added.
; Element Control Panel Update.
; Can now dump bitmap functions directly into clipboard.
; Can now clone a element.
; Smoothing and a lock added to bitmap control panel.
; Text now uses brushes.
; Defaults can now be set and saved to file
; Can now use cursor to set 2 Gradient Brush positions
; Can now use element control panel to adjust all 4 points of a bezier line
; Arrow keys can be used while setting polygon,lines points, gradient points.
; Other minor changes


; Updates: v0.1.4
;---------------------------------------------------------------------------------------------------------------
; Minor Bug fixes

; Updates: v0.1.3
;---------------------------------------------------------------------------------------------------------------
; New control panel to adjust bitmap settings
; You can now zoom in or out of a bitmap.
; You can now adjust the size of a bitmap after it has been created.

; Updates: v0.1.2
;---------------------------------------------------------------------------------------------------------------
; Bitmaps can now be reloaded into the editor later.
; A sound will play and a traytip will pop up when a bitmap is finished saving (Large bitmaps can take 1 min or more to save)
; Multiple copies of the same bitmap can be running at the same time
; Bitmap saves can now be named.
; Bitmap save files can be deleted from within the editor. (Data File and Function File)
; Fixed the output code so that Smoothing is set for the Graphics and not the bitmap (oops)
; Notes will now show up in output code (Functions)
; There is now a master folder that contains 3 additional folders for the saved bitmaps and pngs
; Hidding / UnHidding a element will reselect that element (List was going to the top if the list was longer than dispaly Listbox)


;Version v0.1.8 Paste:    ;March 29th, 2020
;Version v0.1.7 Paste: https://pastebin.com/cdaTYN5U   ;June 6th, 2019
;Version v0.1.3 Paste: https://pastebin.com/pscPkD7g   ;March 9th, 2019
;Version v0.1.2 Paste: https://pastebin.com/QMYpJaxY   ;March 8th, 2019
;Version v0.1.1 Paste: https://pastebin.com/pPBEphce
;Version v0.0.6 Paste: https://pastebin.com/A4h2fdEy

#SingleInstance,Force
SetBatchLines,-1
IfNotExist,%A_ScriptDir%\HB Bitmap Maker Folder
{
	FileCreateDir,%A_ScriptDir%\HB Bitmap Maker Folder
	FileCreateDir,%A_ScriptDir%\HB Bitmap Maker Folder\Saved PNGs
	FileCreateDir,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Data
	FileCreateDir,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions	
}
SetWorkingDir,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Data
global Saved_Bitmap_List
Load_Saved_Bitmap_List()
global Default_Values:={Default_Bitmap_X:320,Default_Bitmap_Y:30,Default_Bitmap_W:200,Default_Bitmap_H:200,Default_Bitmap_Smoothing:4,Default_Element_W:50,Default_Element_H:50,Default_Element_X:10,Default_Element_Y:10,Default_Element_X2:20,Default_Element_Y2:20,Default_Element_X3:30,Default_Element_Y3:30,Default_Element_X4:40,Default_Element_Y4:40,Default_Element_Alpha:"FF",Default_Element_Color:"FF0000",Default_Element_Alpha2:"FF",Default_Element_Color2:"00FF00",Default_Element_Hatch:39,Default_Element_Radius:5,Default_Element_Thickness:3,Default_Element_Start_Angle:0,Default_Element_End_Angle:90,Default_Element_Text:"Hellbent",Default_Element_Font:"Segoe UI",Default_Element_Options:"s16 Center vCenter Bold Underline",Default_Element_Hidden:0,Default_Element_Brush_Type:1,Default_Element_Polygon_List:"100,50|150,100|50,100|",Default_Element_Lines_List:"100,50|150,100|50,100|100,50|",Default_Element_Line_Brush_X1:0,Default_Element_Line_Brush_Y1:0,Default_Element_Line_Brush_X2:100,Default_Element_Line_Brush_Y2:100,Default_Element_Line_Brush_Wrap_Mode:1,Default_Element_Grade_Brush_X:0,Default_Element_Grade_Brush_Y:0,Default_Element_Grade_Brush_W:100,Default_Element_Grade_Brush_H:100,Default_Element_Grade_Brush_Wrap_Mode:1,Default_Element_Grade_Brush_LinearGradientMode:1}
IfNotExist, %A_ScriptDir%\HB Bitmap Maker Folder\Default Values.ini
{
	for k, v in Default_Values
		IniWrite,% v,%A_ScriptDir%\HB Bitmap Maker Folder\Default Values.ini,Defaults,% k
}
for k, v in Default_Values	{
	IniRead,tttt,%A_ScriptDir%\HB Bitmap Maker Folder\Default Values.ini,Defaults,% k
	Default_Values[k]:=tttt
}
global Default_Bitmap_X,Default_Bitmap_Y,Default_Bitmap_W,Default_Bitmap_H,Default_Bitmap_Smoothing,Default_Element_W,Default_Element_H,Default_Element_X,Default_Element_Y,Default_Element_X2,Default_Element_Y2,Default_Element_X3,Default_Element_Y3,Default_Element_X4,Default_Element_Y4,Default_Element_Alpha,Default_Element_Color,Default_Element_Alpha2,Default_Element_Color2,Default_Element_Hatch,Default_Element_Radius,Default_Element_Thickness,Default_Element_Start_Angle,Default_Element_End_Angle,Default_Element_Text,Default_Element_Font,Default_Element_Options,Default_Element_Hidden,Default_Element_Brush_Type,Default_Element_Polygon_List,Default_Element_Lines_List,Default_Element_Line_Brush_X1,Default_Element_Line_Brush_Y1,Default_Element_Line_Brush_X2,Default_Element_Line_Brush_Y2,Default_Element_Line_Brush_Wrap_Mode,Default_Element_Grade_Brush_X,Default_Element_Grade_Brush_Y,Default_Element_Grade_Brush_W,Default_Element_Grade_Brush_H,Default_Element_Grade_Brush_Wrap_Mode,Default_Element_Grade_Brush_LinearGradientMode
global Element_Key_List:= ["Type","X","Y","W","H","X2","Y2","X3","Y3","X4","Y4","Alpha","Color","Alpha2","Color2","Thickness","Radius","Hatch","Notes","Text","Options","Font","Brush_Type","Hidden","Line_Brush_X1","Line_Brush_Y1","Line_Brush_X2","Line_Brush_Y2","Line_Brush_Wrap_Mode","Grade_Brush_X","Grade_Brush_Y","Grade_Brush_W","Grade_Brush_H","Grade_Brush_LinearGradientMode","Grade_Brush_Wrap_Mode","Start_Angle","End_Angle","Polygon_list","Lines_List"]
global Windows:= New Main_Window()
global Selected_New_Element:="Fill_Rectangle",BitmapBackgroundColor
global Current_Elements,Active_Element
global New_Bitmap_Name,New_Bitmap_X,New_Bitmap_Y,New_Bitmap_W,New_Bitmap_H,New_Bitmap_Smoothing,New_Bitmap_Raster
global Bitmap_Array:=[]
global Active_Bitmaps_List
global Active_Bitmap:=1
global Element_Type_List:="Fill_Rectangle||Fill_Rounded_Rectangle|Fill_Circle|Fill_Polygon|Fill_Pie|Draw_Rectangle|Draw_Rounded_Rectangle|Draw_Circle|Draw_Line|Draw_Lines|Draw_Bezier|Draw_Arc|Draw_Pie|Text"  ;|Fill_Region|Fill_Path
global Bitmap_Name_Counter:=1
global Auto_Draw:=1
global Element_Window:=New Element_Windows()
global Constructor:=New Element_Window_Constructor()
global Brush_Type:=1
global Element_Read_Keys
global Name_To_Save_Files
global Unlock_Delete_Button:=0
global Bitmap_Info_Control_Panel:=New Bitmap_Info_Control_Panel()
global Save_Progress:=0
return
GuiClose:
;~ GuiContextMenu:
	ExitApp

Load_Saved_Bitmap_List(){
	Saved_Bitmap_List:=""
	;~ Loop, %A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Data\*.*
	Loop, %A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Data\*.ini
	{
		tep:=StrSplit(A_LoopFileName,".")
		if(A_Index=1)
			Saved_Bitmap_List.=tep[1] "||"
		else 
			Saved_Bitmap_List.=tep[1] "|"
	}
	GuiControl,7:,List_Of_Existing_Saves,|
	GuiControl,7:,List_Of_Existing_Saves,% Saved_Bitmap_List
	GuiControl,6:,List_Of_Saved_Bitmaps,|
	GuiControl,6:,List_Of_Saved_Bitmaps,% Saved_Bitmap_List
}

Clip_Bitmap(){
	GuiControlGet,List_Of_Saved_Bitmaps,6:,List_Of_Saved_Bitmaps
	FileRead,Clipboard,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%List_Of_Saved_Bitmaps%.txt
	Loop 2
		SoundBeep,500
	TrayTip,,Done
}

Set_Auto_Draw(){
	Auto_Draw:=!Auto_Draw
}

Test_Load(){
	GuiControlGet,List_Of_Saved_Bitmaps,6:,List_Of_Saved_Bitmaps
	if(!List_Of_Saved_Bitmaps)
		return
	lBM:={}
	IniRead,tttt,%List_Of_Saved_Bitmaps%.ini,Bitmap Properties,X
	lBM.X:=tttt
	IniRead,tttt,%List_Of_Saved_Bitmaps%.ini,Bitmap Properties,Y
	lBM.Y:=tttt
	IniRead,tttt,%List_Of_Saved_Bitmaps%.ini,Bitmap Properties,W
	lBM.W:=tttt
	IniRead,tttt,%List_Of_Saved_Bitmaps%.ini,Bitmap Properties,H
	lBM.H:=tttt
	IniRead,tttt,%List_Of_Saved_Bitmaps%.ini,Bitmap Properties,Name
	lBM.Name:=tttt
	IniRead,tttt,%List_Of_Saved_Bitmaps%.ini,Bitmap Properties,Smoothing
	lBM.Smoothing:=tttt
	IniRead,tttt,%List_Of_Saved_Bitmaps%.ini,Bitmap Properties,Number Of Elements
	lBM.Number_Of_Elements:=tttt
	c_ele:=1
	lBM.temp_Element:=[]
	gui,1:+OwnDialogs
	Loop,% lBM.Number_Of_Elements
		{
			lBM.temp_Element[A_Index]:={}
			Loop,% Element_Key_List.Length()	{
				IniRead,tttt,%List_Of_Saved_Bitmaps%.ini,Bitmap Element %c_ele%,% Element_Key_List[A_Index]
				LBM.temp_Element[c_ele][Element_Key_List[A_Index]]:=tttt
			}
			c_ele++	
		}
	Load_Bitmap(lbm)
}

Save_Code(){
	Gui,7:Submit,NoHide
	if(Bitmap_Array[Active_Bitmap]&&Name_To_Save_Files){
		Bitmap_Array[Active_Bitmap].Create_BitMap(1)
		loop, % Bitmap_Array[Active_Bitmap].Bitmap_Elements.Length(){
				Bitmap_Array[Active_Bitmap][Bitmap_Array[Active_Bitmap].Bitmap_Elements[A_Index].Type](A_Index,1)
		}
		temp:="`n`tGdip_DeleteGraphics( G )`n`treturn pBitmap`n}"
		FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
		;Save Bitmap data file
		;------------------------------------------------------------
		FileDelete,%Name_To_Save_Files%.ini
		IniWrite,% Bitmap_Array[Active_Bitmap].X,%Name_To_Save_Files%.ini,Bitmap Properties,X
		IniWrite,% Bitmap_Array[Active_Bitmap].Y,%Name_To_Save_Files%.ini,Bitmap Properties,Y
		IniWrite,% Bitmap_Array[Active_Bitmap].W,%Name_To_Save_Files%.ini,Bitmap Properties,W
		IniWrite,% Bitmap_Array[Active_Bitmap].H,%Name_To_Save_Files%.ini,Bitmap Properties,H
		IniWrite,% Bitmap_Array[Active_Bitmap].Name,%Name_To_Save_Files%.ini,Bitmap Properties,Name
		IniWrite,% Bitmap_Array[Active_Bitmap].Smoothing,%Name_To_Save_Files%.ini,Bitmap Properties,Smoothing
		IniWrite,% Bitmap_Array[Active_Bitmap].Bitmap_Elements.Length(),%Name_To_Save_Files%.ini,Bitmap Properties,Number Of Elements
		c_ele:=1
		Loop,% Bitmap_Array[Active_Bitmap].Bitmap_Elements.Length()
		{
			For, k , v in Bitmap_Array[Active_Bitmap].Bitmap_Elements[A_Index]
				IniWrite,% v,%Name_To_Save_Files%.ini,Bitmap Element %c_ele%,% k
			c_ele++	
			
			GuiControl,% "7: +Range0-" Bitmap_Array[Active_Bitmap].Bitmap_Elements.Length() ,Save_Progress
			GuiControl,7:,Save_Progress,% c_ele
		}
	}
	Load_Saved_Bitmap_List()
	loop 2
		SoundBeep,500
	TrayTip,,Done
}

Save_Png(){
	Gui,7:Submit,NoHide
	if(Bitmap_Array[Active_Bitmap]&&Name_To_Save_Files)
    	Gdip_SaveBitmapToFile( Bitmap_Array[Active_Bitmap].Bitmap , A_ScriptDir "\HB Bitmap Maker Folder\Saved PNGs\" Name_To_Save_Files ".PNG" , 100 )
	SoundBeep,700
	TrayTip,,Done
}	

Save_Defaults(){
	For k, v in Default_Values
		IniWrite,% v,%A_ScriptDir%\HB Bitmap Maker Folder\Default Values.ini,Defaults,% k
	Loop 2
		SoundBeep,600
	TrayTip,,Done
}

Add_New_Element(){
	GuiControlGet,Selected_New_Element,1:,Selected_New_Element
	Bitmap_Array[Active_Bitmap].BitMap_Elements.Push(New Element(Selected_New_Element))
	Update_Element_List()
	Active_Element:=Bitmap_Array[Active_Bitmap].BitMap_Elements.Length()
	Element_Window[Selected_New_Element](Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element])
	GuiControl,8:Choose,Current_Elements,% Active_Element
	if(Auto_Draw){
			SetTimer,Force_Draw,-10
		}
}

Clone_Element(){
	if(Bitmap_Array[Active_Bitmap].BitMap_Elements.Length()&&Active_Element){
		Bitmap_Array[Active_Bitmap].BitMap_Elements.Push(New Element(Selected_New_Element))
		For,k,v in Element_Key_List
			Bitmap_Array[Active_Bitmap].BitMap_Elements[Bitmap_Array[Active_Bitmap].BitMap_Elements.Length()][v]:=Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element][v]
		Active_Element:=Bitmap_Array[Active_Bitmap].BitMap_Elements.Length()
		Element_Window[Selected_New_Element](Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element])
		GuiControl,8:Choose,Current_Elements,% Active_Element
		Set_Bitmap_Controls()
		Update_Element_List()
		GuiControl,8:Choose,Current_Elements,% Active_Element
		if(Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Brush_Type=3){
			GuiControl,13:,Line,1
		}
		if(Auto_Draw){
				SetTimer,Force_Draw,-10
			}	
	}
}

Switch_Active_Element(){
	Gui,8:Submit,NoHide
	Active_Element:=Current_Elements
	Set_Bitmap_Controls()
	Element_Window[Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Type](Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element])
	;~ Set_Bitmap_Controls()
}

Update_Element_List(){
	Element_List:=""
	Loop,% Bitmap_Array[Active_Bitmap].BitMap_Elements.Length(){
		if(Bitmap_Array[Active_Bitmap].BitMap_Elements[A_Index].Hidden=1&&Bitmap_Array[Active_Bitmap].BitMap_Elements[A_Index].Notes)
			Element_List.="( N H )  " Bitmap_Array[Active_Bitmap].BitMap_Elements[A_Index].Type  "|"
		else if(Bitmap_Array[Active_Bitmap].BitMap_Elements[A_Index].Notes)
			Element_List.="( N )  " Bitmap_Array[Active_Bitmap].BitMap_Elements[A_Index].Type  "|"
		else if(Bitmap_Array[Active_Bitmap].BitMap_Elements[A_Index].Hidden=1)
			Element_List.="( H )  " Bitmap_Array[Active_Bitmap].BitMap_Elements[A_Index].Type  "|"
		else
			Element_List.=Bitmap_Array[Active_Bitmap].BitMap_Elements[A_Index].Type  "|"
	}
	GuiControl,8:,Current_Elements,|
	GuiControl,8:,Current_Elements,% Element_List
}

ReOrder_Elements(){
	if(Active_Element){
		if(A_GuiControl="ReOrder_Up"&&Active_Element!=1){
			tempElement:=Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element]
			Bitmap_Array[Active_Bitmap].BitMap_Elements.RemoveAt(Active_Element)
			Bitmap_Array[Active_Bitmap].BitMap_Elements.InsertAt(Active_Element-1,tempElement)
			Update_Element_List()
			GuiControl,8:Choose,Current_Elements,% Active_Element-1
			Switch_Active_Element()
			
		}else if(A_GuiControl="ReOrder_Down"&&Active_Element!=Bitmap_Array[Active_Bitmap].BitMap_Elements.Length()){
			tempElement:=Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element]
			Bitmap_Array[Active_Bitmap].BitMap_Elements.RemoveAt(Active_Element)
			Bitmap_Array[Active_Bitmap].BitMap_Elements.InsertAt(Active_Element+1,tempElement)
			Update_Element_List()
			GuiControl,8:Choose,Current_Elements,% Active_Element+1
			Switch_Active_Element()
		}
	}
	if(Auto_Draw){
			SetTimer,Force_Draw,-10
		}
}

Remove_Element(){
	if(Active_Element){
		Bitmap_Array[Active_Bitmap].BitMap_Elements.RemoveAt(Active_Element)
		Update_Element_List()
		if(Bitmap_Array[Active_Bitmap].BitMap_Elements.Length()){
			(Active_Element != 1) ? (Active_Element-=1)
			GuiControl,8:Choose,Current_Elements,% Active_Element
			Element_Window[Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Type](Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element])
		}else	{
			Active_Element:=""
			Gui,13:Destroy  
			Gui,14:Destroy  
			Gui,15:Destroy  
		}
	}
	if(Auto_Draw){
			SetTimer,Force_Draw,-10
		}
}

Load_Bitmap(lBM){
	Bitmap_Name_Counter++
	Gui,5:Submit,NoHide
	Bitmap_Array.Push(New Bitmap_Class(lBM.X,lBM.Y,lBM.W,lBM.H,lBM.Smoothing,New_Bitmap_Name,New_Bitmap_Raster))
	GuiControl,5:,New_Bitmap_Name,% Bitmap_Name_Counter
		Active_Bitmap:=Bitmap_Array.Length()
	Add_Bitmaps_To_Bitmaps_List()
	GuiControl,1:Choose,Active_Bitmaps_List,% Active_Bitmap
	Loop,% Bitmap_Array.Length()
			Bitmap_Array[A_Index].move()
	if(Bitmap_Array.Length()=1){
		GuiControl,1:,Selected_New_Element,|
		GuiControl,1:,Selected_New_Element,% Element_Type_List	
	}
	Loop,% lbm.temp_Element.Length()	{
		Add_New_Element()
		indext:=A_Index
		For,k,v in lbm.temp_Element[A_Index]
			Bitmap_Array[Bitmap_Array.Length()].BitMap_Elements[indext][k]:=v
	}
	GuiControl,7:,Display_Current_Bitmap_Name ,`nActive Bitmap : %Active_Bitmap% 
	Set_Bitmap_Controls()
	Update_Element_List()
}

Set_Bitmap_Controls(){
	Bitmap_Info_Control_Panel.Create_Bitmap_Control_Panel()
	Bitmap_Info_Control_Panel.Bitmap_Position_Controls()
	Bitmap_Info_Control_Panel.Bitmap_Position_Details(Bitmap_Array[Active_Bitmap])
	Bitmap_Info_Control_Panel.Bitmap_Zoom(Bitmap_Array[Active_Bitmap])
	Bitmap_Info_Control_Panel.Bitmap_Lock()
	Bitmap_Info_Control_Panel.Bitmap_Smoothing()
	Bitmap_Info_Control_Panel.Show_Bitmap_Control_Panel()
}

Add_New_Bitmap(){
	Bitmap_Name_Counter++
	Gui,5:Submit,NoHide
	Bitmap_Array.Push(New Bitmap_Class(New_Bitmap_X,New_Bitmap_Y,New_Bitmap_W,New_Bitmap_H,New_Bitmap_Smoothing,New_Bitmap_Name,New_Bitmap_Raster))
	GuiControl,5:,New_Bitmap_Name,% Bitmap_Name_Counter
	if(!Active_Bitmap)
		Active_Bitmap:=1
	Add_Bitmaps_To_Bitmaps_List()
	GuiControl,1:Choose,Active_Bitmaps_List,% Active_Bitmap
	GuiControl,7:,Display_Current_Bitmap_Name ,`nActive Bitmap : %Active_Bitmap% 
	Loop,% Bitmap_Array.Length()
			Bitmap_Array[A_Index].move()
	if(Bitmap_Array.Length()=1){
		GuiControl,1:,Selected_New_Element,|
		GuiControl,1:,Selected_New_Element,% Element_Type_List	
	}
	Set_Bitmap_Controls()
}

Set_Active_Bitmap(){
	GuiControlGet,Active_Bitmap,1:,Active_Bitmaps_List
	GuiControl,7:,Display_Current_Bitmap_Name ,`nActive Bitmap : %Active_Bitmap% 
	Update_Element_List()
	if(Bitmap_Array[Active_Bitmap].BitMap_Elements.Length()){
		(Active_Element != 1) ? (Active_Element-=1)
		GuiControl,8:Choose,Current_Elements,% Active_Element
		Element_Window[Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Type](Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element])
		;~ Set_Bitmap_Controls()
	}else	{
		Active_Element:=""
		Gui,13:Destroy  
	}
	if(Bitmap_Array.Length())
		Set_Bitmap_Controls()
}

Remove_Active_Bitmap(){
	if(Bitmap_Array.Length()>0){
		GuiControlGet,Active_Bitmap,1:,Active_Bitmaps_List
		GuiControl,4:+Redraw,% Bitmap_Array[Active_Bitmap].Name
		GuiControl,4:Hide,% Bitmap_Array[Active_Bitmap].Name
		Bitmap_Array.RemoveAt(Active_Bitmap)
		(Active_Bitmap>1)?(Active_BitMap-=1)
		Add_Bitmaps_To_Bitmaps_List()
		GuiControl,1:Choose,Active_Bitmaps_List,% Active_Bitmap
		Set_Active_Bitmap()	
		if(Bitmap_Array.Length()<1)	{
			GuiControl,1:,Selected_New_Element,|
			GuiControl,8:,Current_Elements,|
			Gui,13:Destroy
			Gui,14:Destroy
			Gui,15:Destroy
			Gui,17:Destroy
		}
	}
}

;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Element_Windows
;**********************************************************************************************

Class Element_Windows	{
	Fill_Rectangle(Obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rectangle_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		
		Constructor.Show_Window()
	}
	Fill_Rounded_Rectangle(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rounded_Rectangle_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
	Fill_Circle(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rectangle_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
	Fill_Pie(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rectangle_Lines(obj)
		Constructor.Angle_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
	Fill_Polygon(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		
		Constructor.Polygon_Lines(obj)
		
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Position_Buttons_Polygon(obj)
		Constructor.Show_Window()
		
	}
	Draw_Rectangle(Obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rectangle_Lines(obj)
		Constructor.Line_Thickness_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
	Draw_Rounded_Rectangle(Obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rounded_Rectangle_Lines(obj)
		Constructor.Line_Thickness_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
	Draw_Circle(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rectangle_Lines(obj)
		Constructor.Line_Thickness_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
	Draw_Line(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Two_Points_Lines(obj)
		Constructor.Line_Thickness_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_X2_Y2()
		Constructor.Show_Window()
	}
	Draw_Lines(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Line_Thickness_Lines(obj)
		Constructor.Lines_Lines(obj)
		
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Position_Buttons_Polygon(obj)
		Constructor.Show_Window()
		
	}
	Draw_Arc(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rectangle_Lines(obj)
		Constructor.Angle_Lines(obj)
		Constructor.Line_Thickness_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
	Draw_Pie(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rectangle_Lines(obj)
		Constructor.Angle_Lines(obj)
		Constructor.Line_Thickness_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
	Draw_Bezier(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Bezier_Lines(obj)
		Constructor.Line_Thickness_Lines(obj)
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_X2_Y2()
		Constructor.Positioning_Buttons_X3_Y3_X4_Y4()
		Constructor.Show_Window()
	}
	Text(obj){
		Constructor.Window_Settings()
		Constructor.Hide_Element_Line(obj)
		Constructor.Notes_Line(obj)
		Constructor.Rectangle_Lines(obj)
		Constructor.Text_Lines(obj)
		
		Constructor.Brush_Options_Lines(obj)
		Constructor.Create_Brush_Window(obj)
		
		Constructor.Fine_Control_Window(obj)
		Constructor.Positioning_Buttons_X_Y()
		Constructor.Positioning_Buttons_W_H()
		Constructor.Show_Window()
	}
}

;**********************************************************************************************

; Element_Window_Constructor
;**********************************************************************************************

Class Element_Window_Constructor	{
	Window_Settings(){
		Gui,13:Destroy
		Gui,13:+Parent12 -Caption -DPIScale 
		Gui,13:Color,333333,333333
		Gui,13:Font,cWhite s8 ,Segoe Ui
	}
	Show_Window(){
		Gui,13:Show,x0 y0 w290 h380 ,
	}
	Notes_Line(obj){
		global
		Gui,13:Add,Text,x10 y+10 w40 r1,Notes :
		Gui,13:Add,Edit,x+10 yp-2 w220 r1 -E0x200 +Border vNotes gSubmit_13 ,% obj.Notes
	}
	Rectangle_Lines(obj){
		global
		Gui,13:Add,Text,x10 y+10 w15 r1 ,X :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vX_Position gSubmit_13,% obj.X
		Gui,13:Add,Text,x+5 yp+4 w15 r1 ,Y :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vY_Position gSubmit_13,% obj.Y
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,W :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center Number -E0x200 +Border vW_Position gSubmit_13,% obj.W
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,H :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center Number -E0x200 +Border vH_Position gSubmit_13,% obj.H
	}
	Polygon_Lines(obj){
		global
		Gui,13:Add,Text,x10 y+20 w60 r1 ,Positions :
		Gui,13:Add,Edit,x10 y+10 w270 r1 vPolygon_List gSubmit_13,% obj.Polygon_List
		Gui,13:Add,Button,x10 y+20 w80 h25 -Theme gAdd_New_Polygon_Point, Add Point
		Gui,13:Add,Button,x+10  w80 h25 -Theme gClear_Points, Clear
	}
	Lines_Lines(obj){
		global
		Gui,13:Add,Text,x10 y+10 w60 r1 ,Positions :
		Gui,13:Add,Edit,x10 y+5 w270 r1 vLines_List gSubmit_13,% obj.Lines_List
		Gui,13:Add,Button,x10 y+10 w80 h25 -Theme gAdd_New_Lines_Point, Add Point
		Gui,13:Add,Button,x+10  w80 h25 -Theme gClear_Points, Clear
	}
	Rounded_Rectangle_Lines(obj){
		global
		Gui,13:Add,Text,x10 y+15 w15 r1 ,X :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vX_Position gSubmit_13,% obj.X
		Gui,13:Add,Text,x+5 yp+4 w15 r1 ,Y :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vY_Position gSubmit_13,% obj.Y
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,W :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center Number -E0x200 +Border vW_Position gSubmit_13,% obj.W
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,H :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center Number -E0x200 +Border vH_Position gSubmit_13,% obj.H
		Gui,13:Add,Text,x10 y+12 w50 r1,Radius :
		Gui,13:Add,Edit,x+10 yp-4 w50 r1 Center -E0x200 +Border Uppercase vRadius gSubmit_13,% obj.Radius
	}
	Brush_Options_Lines(obj){
		global
		Gui,13:Add,Radio,x10 y180 -Theme Group AltSubmit vBrush_Type gSubmit_Brush_Type,Normal
		Gui,13:Add,Radio,x+10 yp -Theme gSubmit_Brush_Type,Hatch
		Gui,13:Add,Radio,x+10 yp -Theme gSubmit_Brush_Type,Lines
		Gui,13:Add,Radio,x+10 yp -Theme gSubmit_Brush_Type,Grade
		if(obj.Brush_Type=1)
			GuiControl,13:,Brush_Type,1
		else if(obj.Brush_Type=2)
			GuiControl,13:,Hatch,1
		else if(obj.Brush_Type=3)
			GuiControl,13:,Lines,1
		else if(obj.Brush_Type=4)
			GuiControl,13:,Grade,1
	}
	Hide_Element_Line(obj){
		global
		if(obj.Hidden)
			Gui,13:Add,Checkbox,x10 y10 Checked vHide_Element gHide_Element,Hide Element
		else
			Gui,13:Add,Checkbox,x10 y10 vHide_Element gHide_Element,Hide Element
	}
	Line_Thickness_Lines(obj){
		Gui,13:Add,Text,x10 y+10 w80 r1,Thickness :
		Gui,13:Add,Edit,x+10 yp-2 w40 r1 Center -E0x200 +Border vThickness gSubmit_13 ,% obj.Thickness
	}
	Two_Points_Lines(obj){
		Gui,13:Add,Text,x10 y+15 w25 r1 ,X :
		Gui,13:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vX_Position gSubmit_13,% obj.X
		Gui,13:Add,Text,x+10 yp+4 w25 r1 ,Y :
		Gui,13:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vY_Position gSubmit_13,% obj.Y
		Gui,13:Add,Text,x10 y+15 w25 r1 ,X2 :
		Gui,13:Add,Edit,x+10 yp-4 w40 r1 Center Number -E0x200 +Border vX2_Position gSubmit_13,% obj.X2
		Gui,13:Add,Text,x+10 yp+4 w25 r1 ,Y2 :
		Gui,13:Add,Edit,x+10 yp-4 w40 r1 Center Number -E0x200 +Border vY2_Position gSubmit_13,% obj.Y2
	}
	Bezier_Lines(obj){
		Gui,13:Add,Text,x5 y+10 w15 r1 ,X :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vX_Position gSubmit_13,% obj.X
		Gui,13:Add,Text,x+5 yp+4 w15 r1 ,Y :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vY_Position gSubmit_13,% obj.Y
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,X2 :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vX2_Position gSubmit_13,% obj.X2
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,Y2 :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vY2_Position gSubmit_13,% obj.Y2
		Gui,13:Add,Text,x5 y+10 w20 r1 ,X3 :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vX3_Position gSubmit_13,% obj.X3
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,Y3 :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vY3_Position gSubmit_13,% obj.Y3
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,X4 :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vX4_Position gSubmit_13,% obj.X4
		Gui,13:Add,Text,x+5 yp+4 w20 r1 ,Y4 :
		Gui,13:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vY4_Position gSubmit_13,% obj.Y4
	}
	Angle_Lines(obj){
		Gui,13:Add,Text,x10 y+15 w70 r1 ,Start Angle :
		Gui,13:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vStart_Angle gSubmit_13,% obj.Start_Angle
		Gui,13:Add,Text,x+10 yp+4 w80 r1 ,Sweep Angle :
		Gui,13:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vEnd_Angle gSubmit_13,% obj.End_Angle
	}
	Text_Lines(obj){
		Gui,13:Add,Text,x10 y+7 w40 r1,Text :
		Gui,13:Add,Edit,x+10 yp-2 w220 r1 -E0x200 +Border vText gSubmit_13 ,% obj.Text
		Gui,13:Add,Text,x10 y+7 w50 r1,Options :
		Gui,13:Add,Edit,x+10 yp-2 w210 r1 -E0x200 +Border vOptions gSubmit_13 ,% obj.Options
		Gui,13:Add,Text,x10 y+7 w40 r1,Font :
		Gui,13:Add,Edit,x+10 yp-2 w220 r1 -E0x200 +Border vFont gSubmit_13 ,% obj.Font
		
	}
	Create_Brush_Window(obj){
		Gui,14:Destroy
		Gui,14:+AlwaysOnTop -Caption -DpiScale +Parent13 
		Gui,14:Color,333333,444444
		Gui,14:Font,cWhite s8 ,Segoe Ui
		Gui,14:Show,x0 y200 w290 h200
		if(obj.Brush_Type=1)
			This.Normal_Brush_Window(obj)
		else if(obj.Brush_Type=2)
			This.Hatch_Brush_Window(obj)
		else if(obj.Brush_Type=3)
			This.Line_Brush_Window(obj)
		else if(obj.Brush_Type=4)
			This.Grade_Brush_Window(obj)
	}
	Normal_Brush_Window(obj){
		Gui,14:Add,Text,x5 y30 w40 r1 ,Alpha :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center Limit2 -E0x200 +Border vAlpha gSubmit_13,% obj.Alpha
		Gui,14:Add,Text,x+5 yp+4 w40 r1 ,Color :
		Gui,14:Add,Edit,x+5 yp-4 w60 r1 Center Limit6 -E0x200 +Border vColor gSubmit_13,% obj.Color
		Gui,14:Add,Button,x+10 yp w70 h20 -Theme gSet_Color_1,Get 
		Gui,14:Submit,NoHide
	}
	Hatch_Brush_Window(obj){
		Gui,14:Add,Text,x5 y20 w40 r1 ,Alpha :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center Limit2 -E0x200 +Border vAlpha gSubmit_13,% obj.Alpha
		Gui,14:Add,Text,x+5 yp+4 w40 r1 ,Color :
		Gui,14:Add,Edit,x+5 yp-4 w60 r1 Center Limit6 -E0x200 +Border vColor gSubmit_13,% obj.Color
		Gui,14:Add,Button,x+10 yp w70 h20 -Theme gSet_Color_1,Get 
		
		Gui,14:Add,Text,x5 y+10 w40 r1 ,Alpha 2 :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center Limit2 -E0x200 +Border vAlpha2 gSubmit_13,% obj.Alpha2
		Gui,14:Add,Text,x+5 yp+4 w40 r1 ,Color2 :
		Gui,14:Add,Edit,x+5 yp-4 w60 r1 Center Limit6 -E0x200 +Border vColor2 gSubmit_13,% obj.Color2
		Gui,14:Add,Button,x+10 yp w70 h20 -Theme gSet_Color_2,Get 
		
		Gui,14:Add,Text,x5 y+10 w40 r1 ,Hatch :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center Limit2 -E0x200 +Border vHatch gSubmit_13,% obj.Hatch
		Gui,14:Submit,NoHide
		
	}
	Line_Brush_Window(obj){
		Gui,14:Add,Text,x5 y10 w40 r1 ,Alpha :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center Limit2 -E0x200 +Border vAlpha gSubmit_13,% obj.Alpha
		Gui,14:Add,Text,x+5 yp+4 w40 r1 ,Color :
		Gui,14:Add,Edit,x+5 yp-4 w60 r1 Center Limit6 -E0x200 +Border vColor gSubmit_13,% obj.Color
		Gui,14:Add,Button,x+10 yp w70 h20 -Theme gSet_Color_1,Get 
		
		Gui,14:Add,Text,x5 y+10 w40 r1 ,Alpha 2 :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center Limit2 -E0x200 +Border vAlpha2 gSubmit_13,% obj.Alpha2
		Gui,14:Add,Text,x+5 yp+4 w40 r1 ,Color2 :
		Gui,14:Add,Edit,x+5 yp-4 w60 r1 Center Limit6 -E0x200 +Border vColor2 gSubmit_13,% obj.Color2
		Gui,14:Add,Button,x+10 yp w70 h20 -Theme gSet_Color_2,Get 
		
		Gui,14:Add,Text,x10 y+10 w25 r1 ,X1 :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vLine_Brush_X1 gSubmit_13,% obj.Line_Brush_X1
		Gui,14:Add,Text,x+10 yp+4 w25 r1 ,Y1 :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vLine_Brush_Y1 gSubmit_13,% obj.Line_Brush_Y1
		
		Gui,14:Add,Text,x10 y+10 w25 r1 ,X2 :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vLine_Brush_X2 gSubmit_13,% obj.Line_Brush_X2
		Gui,14:Add,Text,x+10 yp+4 w25 r1 ,Y2 :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vLine_Brush_Y2 gSubmit_13,% obj.Line_Brush_Y2
		Gui,14:Add,Button,x+40 yp w70 r1 -Theme gSet_LineBrush_Positions, Set
		Gui,14:Add,Text,x10 y+10 w65 r1 ,Wrap Mode :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vLine_Brush_Wrap_Mode gSubmit_13,% obj.Line_Brush_Wrap_Mode
		Gui,14:Submit,NoHide
	}
	Grade_Brush_Window(obj){
		Gui,14:Add,Text,x5 y10 w40 r1 ,Alpha :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center Limit2 -E0x200 +Border vAlpha gSubmit_13,% obj.Alpha
		Gui,14:Add,Text,x+5 yp+4 w40 r1 ,Color :
		Gui,14:Add,Edit,x+5 yp-4 w60 r1 Center Limit6 -E0x200 +Border vColor gSubmit_13,% obj.Color
		Gui,14:Add,Button,x+10 yp w70 h20 -Theme gSet_Color_1,Get 
		
		Gui,14:Add,Text,x5 y+10 w40 r1 ,Alpha 2 :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center Limit2 -E0x200 +Border vAlpha2 gSubmit_13,% obj.Alpha2
		Gui,14:Add,Text,x+5 yp+4 w40 r1 ,Color2 :
		Gui,14:Add,Edit,x+5 yp-4 w60 r1 Center Limit6 -E0x200 +Border vColor2 gSubmit_13,% obj.Color2
		Gui,14:Add,Button,x+10 yp w70 h20 -Theme gSet_Color_2,Get 
		
		Gui,14:Add,Text,x10 y+10 w25 r1 ,X :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vGrade_Brush_X gSubmit_13,% obj.Grade_Brush_X
		Gui,14:Add,Text,x+10 yp+4 w25 r1 ,Y :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vGrade_Brush_Y gSubmit_13,% obj.Grade_Brush_Y
		Gui,14:Add,Text,x10 y+10 w25 r1 ,W :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vGrade_Brush_W gSubmit_13,% obj.Grade_Brush_W
		Gui,14:Add,Text,x+10 yp+4 w25 r1 ,H :
		Gui,14:Add,Edit,x+10 yp-4 w40 r1 Center -E0x200 +Border vGrade_Brush_H gSubmit_13,% obj.Grade_Brush_H
		Gui,14:Add,Button,x+40 yp w70 r1 -Theme gSet_GradeBrush_Positions, Set
		
		Gui,14:Add,Text,x5 y+10 w65 r1 ,Wrap Mode :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vGrade_Brush_Wrap_Mode gSubmit_13,% obj.Grade_Brush_Wrap_Mode
		Gui,14:Add,Text,x+10 yp+4 w110 r1 ,LinearGradientMode :
		Gui,14:Add,Edit,x+5 yp-4 w40 r1 Center -E0x200 +Border vGrade_Brush_LinearGradientMode gSubmit_13,% obj.Grade_Brush_LinearGradientMode
		Gui,14:Submit,NoHide
	}
	Fine_Control_Window(obj){
		Gui,15:Destroy
		Gui,15:+AlwaysOnTop -Caption -DpiScale +Parent11 
		Gui,15:Color,333333,444444
		Gui,15:Font,cWhite s8 ,Segoe Ui
		Gui,15:Show,x0 y0 w290 h200
	}
	Positioning_Buttons_X_Y(){
		global
		Gui,15:Font,cWhite s8 , ;Segoe Ui
		Gui,15:Add,Button,x35 y10 w50 h25 -Theme vMove_Up gRePosition_Element,Y Up
		Gui,15:Add,Button,x5 y+5 w50 h25 -Theme vMove_Left gRePosition_Element,X Left
		Gui,15:Add,Button,x+10 yp w50 h25 -Theme vMove_Right gRePosition_Element,X Right
		Gui,15:Add,Button,x35 y+5 w50 h25 -Theme vMove_Down gRePosition_Element,Y Down
		
	}
	Positioning_Buttons_X2_Y2(){
		global
		Gui,15:Font,cWhite s8 ,Segoe Ui
		Gui,15:Add,Button,x151 y10 w60 h25 -Theme vMove_Up2 gRePosition_Element,Y2 Up
		Gui,15:Add,Button,x123 y+5 w60 h25 -Theme vMove_Left2 gRePosition_Element,X2 Left
		Gui,15:Add,Button,x+6 yp w60 h25 -Theme vMove_Right2 gRePosition_Element,X2 Right
		Gui,15:Add,Button,x151 y+5 w60 h25 -Theme vMove_Down2 gRePosition_Element,Y2 Down
		
	}
	Positioning_Buttons_X3_Y3_X4_Y4(){
		global
		Gui,15:Font,cWhite s8 , ;Segoe Ui
		Gui,15:Add,Button,x35 y110 w50 h25 -Theme vMove_Up3 gRePosition_Element,Y3 
		Gui,15:Add,Button,x5 y+5 w50 h25 -Theme vMove_Left3 gRePosition_Element,X3 
		Gui,15:Add,Button,x+10 yp w50 h25 -Theme vMove_Right3 gRePosition_Element,X3 
		Gui,15:Add,Button,x35 y+5 w50 h25 -Theme vMove_Down3 gRePosition_Element,Y3 
		
		Gui,15:Add,Button,x151 y110 w60 h25 -Theme vMove_Up4 gRePosition_Element,Y4
		Gui,15:Add,Button,x123 y+5 w60 h25 -Theme vMove_Left4 gRePosition_Element,X4
		Gui,15:Add,Button,x+6 yp w60 h25 -Theme vMove_Right4 gRePosition_Element,X4
		Gui,15:Add,Button,x151 y+5 w60 h25 -Theme vMove_Down4 gRePosition_Element,Y4
	}
	Positioning_Buttons_W_H(){
		global
		Gui,15:Font,cWhite s8 ,Segoe Ui
		Gui,15:Add,Button,x130 y20 w50 h25 -Theme vMinus_Width gReSize_Element,-W
		Gui,15:Add,Button,x+10 yp w50 h25 -Theme vPlus_Width gReSize_Element,+W
		Gui,15:Add,Button,x130 y+10 w50 h25 -Theme vMinus_Height gReSize_Element,-H
		Gui,15:Add,Button,x+10 yp w50 h25 -Theme vPlus_Height gReSize_Element,+H
	}
	Position_Buttons_Polygon(obj){
		global
		Gui,15:Font,cWhite s8 , ;Segoe Ui
		Gui,15:Add,Button,x40 y10 w50 h25 -Theme vMove_Up gRePosition_Polygon_Element,Y Up
		Gui,15:Add,Button,x10 y+5 w50 h25 -Theme vMove_Left gRePosition_Polygon_Element,X Left
		Gui,15:Add,Button,x+10 yp w50 h25 -Theme vMove_Right gRePosition_Polygon_Element,X Right
		Gui,15:Add,Button,x40 y+5 w50 h25 -Theme vMove_Down gRePosition_Polygon_Element,Y Down
		
		Gui,15:Add,ListBox,x150 y10 w80 h90 -Theme
		
		Gui,15:Add,Button,x10 y105 w105 h25 -Theme ,<-- Back
		Gui,15:Add,Button,x+20 y105 w105 h25 -Theme ,Next -->
		
		
		Gui,15:Add,Text,x10 y140 w30 h20 ,X :
		Gui,15:Add,Edit,x+0 w50 h20 Center -E0x200 Border,
		Gui,15:Add,Text,x+15 y140 w30 h20 ,Y :
		Gui,15:Add,Edit,x+0 w50 h20 Center -E0x200 Border,
		Gui,15:Add,Button,x+10 yp w50 h25 -Theme ,Set
		
		Gui,15:Add,Button,x5 y170 w75 h25 -Theme,Add
		Gui,15:Add,Button,x+5  w75 h25 -Theme,Remove
		Gui,15:Add,Button,x+5  w75 h25 -Theme,Insert
		
	}
}
;**********************************************************************************************

; Master Element Class
;**********************************************************************************************
Class Element	{
	__New(Type){
		This.Type:=Type
		This.X:=								Default_Values.Default_Element_X
		This.Y:=								Default_Values.Default_Element_Y
		This.W:=								Default_Values.Default_Element_W
		This.H:=								Default_Values.Default_Element_H
		This.X2:=								Default_Values.Default_Element_X2
		This.Y2:=  								Default_Values.Default_Element_Y2
		This.X3:=								Default_Values.Default_Element_X3
		This.Y3:=								Default_Values.Default_Element_Y3
		This.X4:=								Default_Values.Default_Element_X4
		This.Y4:=								Default_Values.Default_Element_Y4
		This.Alpha:=							Default_Values.Default_Element_Alpha
		This.Color:=							Default_Values.Default_Element_Color
		This.Alpha2:=							Default_Values.Default_Element_Alpha2
		This.Color2:=							Default_Values.Default_Element_Color2
		This.Thickness:=						Default_Values.Default_Element_Thickness
		This.Radius:=							Default_Values.Default_Element_Radius
		This.Hatch:=							Default_Values.Default_Element_Hatch
		This.Notes:=""
		This.Text:=								Default_Values.Default_Element_Text
		This.Options:=							Default_Values.Default_Element_Options
		This.Font:=								Default_Values.Default_Element_Font
		This.Brush_Type:=						Default_Values.Default_Element_Brush_Type
		This.Hidden:=							Default_Values.Default_Element_Hidden
		This.Line_Brush_X1:=					Default_Values.Default_Element_Line_Brush_X1
		This.Line_Brush_Y1:=					Default_Values.Default_Element_Line_Brush_Y1
		This.Line_Brush_X2:=					Default_Values.Default_Element_Line_Brush_X2
		This.Line_Brush_Y2:=					Default_Values.Default_Element_Line_Brush_Y2
		This.Line_Brush_Wrap_Mode:=				Default_Values.Default_Element_Line_Brush_Wrap_Mode
		This.Grade_Brush_X:=					Default_Values.Default_Element_Grade_Brush_X
		This.Grade_Brush_Y:=					Default_Values.Default_Element_Grade_Brush_Y
		This.Grade_Brush_W:=					Default_Values.Default_Element_Grade_Brush_W
		This.Grade_Brush_H:=					Default_Values.Default_Element_Grade_Brush_H
		This.Grade_Brush_LinearGradientMode:=	Default_Values.Default_Element_Grade_Brush_LinearGradientMode
		This.Grade_Brush_Wrap_Mode:=			Default_Values.Default_Element_Grade_Brush_Wrap_Mode
		This.Start_Angle:=						Default_Values.Default_Element_Start_Angle
		This.End_Angle:=						Default_Values.Default_Element_End_Angle
		This.Polygon_List:=						Default_Values.Default_Element_Polygon_List
		This.Lines_List:=						Default_Values.Default_Element_Lines_List
	}
}

;**********************************************************************************************

;    Main Windows Class
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class Main_Window	{
	;~ __New(x:=1366,y:=0,w:=1350,h:=700){
	__New(x:=0,y:=0,w:=1350,h:=700){
		This.X:=x, This.Y:=y, This.W:=w, This.H:=h
		This.Create_Main_Window()
		This.Create_Left_Control_Window()
		This.Create_Right_Control_Window()
		This.Create_Element_Control_Window()
		This.Create_Bitmap_Control_Panel()
		This.Inner_Window()
		This.Setup_Gdip()
	}
	Create_Main_Window(){
		global
		Gui,1: +LastFound -DPIScale +AlwaysOnTop
		Gui,1:Color,222222,333333
		Gui,1:Font,cWhite s10 q5, Segoe UI
		Gui,1:Add,Progress,% "x0 y0 w" This.W " h3  Background880000"
		Gui,1:Add,Progress,% "x0 y" This.H-3 " w" This.W " h3  Background880000"
		Gui,1:Add,Button,x305 y5 w110 r1 -Theme gRemove_Active_Bitmap,Remove Bitmap
		Gui,1:Add,DDL,x+5 y5 w160 r20 -Theme AltSubmit vActive_Bitmaps_List,
		Gui,1:Add,Button,x+5 yp w110 r1 -Theme gSet_Active_Bitmap,Activate Bitmap
		
		Gui,1:Add,DDL,x+25 y5 w190 r20 -Theme vSelected_New_Element , 
		Gui,1:Add,Button,x+5 yp w130 r1 -Theme gAdd_New_Element,Add
		
		Gui,1:Show,% "x" This.X " y" This.Y " w" This.W " h" This.H ,HB Bitmap Maker
		
	}
	Create_Left_Control_Window(){
		global
		Gui,2:+AlwaysOnTop -DPIScale -Caption +Parent1
		Gui,2:Color,333333,444444
		Gui,2:Font,cWhite s10 q5, Segoe UI
		Gui,2:Add,Progress,% "x297 y0 w3 h" This.H " Background880000"
		Gui,2:Add,Text,x8 y10 w90 h30 vTab1 gSwap_Tabs,Tab 1 trigger
		Gui,2:Add,Text,x+5 y10 w90 h30 vTab2 gSwap_Tabs,Tab 2 trigger
		Gui,2:Add,Text,x+5 y10 w90 h30 vTab3 gSwap_Tabs,Tab 3 trigger
		Gui,2:Add,Progress,x3 y5 w290 h40 Background442222
		Gui,2:Add,Progress,x8 y10 w90 h30 Background3399FF vTab1_Background
		Gui,2:Add,Progress,x+5 y10 w90 h30 Background777777 vTab2_Background
		Gui,2:Add,Progress,x+5 y10 w90 h30 Background777777 vTab3_Background
		Gui,2:Add,Text,cBlack x8 y10 w90 h30 Border Center BackgroundTrans 0x200 vTab1_Text,New
		Gui,2:Add,Text,cBlack x+5 y10 w90 h30 Border Center BackgroundTrans 0x200 vTab2_Text,Load
		Gui,2:Add,Text,cBlack x+5 y10 w90 h30 Border Center BackgroundTrans 0x200 vTab3_Text,Save
		Gui,2:Show,% "x0 y0 w300 h" This.H
		This.Create_Window_2_Tabs()
	}
	Create_Right_Control_Window(){
		global
		Gui,3:+AlwaysOnTop -DPIScale -Caption +Parent1
		Gui,3:Color,333333,444444
		Gui,3:Font,cWhite s10 q5, Segoe UI
		Gui,3:Add,Progress,% "x0 y0 w3 h" This.H " Background880000"
		
		Gui,3:Add,Text,x8 y10 w90 h30 vTab4 gSwap_Tabs,Tab 4 trigger
		Gui,3:Add,Text,x+5 y10 w90 h30 vTab5 gSwap_Tabs,Tab 5 trigger
		Gui,3:Add,Text,x+5 y10 w90 h30 vTab6 gSwap_Tabs,Tab 6 trigger
		Gui,3:Add,Progress,x3 y5 w290 h40 Background442222
		Gui,3:Add,Progress,x8 y10 w90 h30 Background3399FF vTab4_Background
		Gui,3:Add,Progress,x+5 y10 w90 h30 Background777777 vTab5_Background
		Gui,3:Add,Progress,x+5 y10 w90 h30 Background777777 vTab6_Background
		Gui,3:Add,Text,cBlack x8 y10 w90 h30 Border Center BackgroundTrans 0x200 vTab4_Text,Elements
		Gui,3:Add,Text,cBlack x+5 y10 w90 h30 Border Center BackgroundTrans 0x200 vTab5_Text,Defaults
		Gui,3:Add,Text,cBlack x+5 y10 w90 h30 Border Center BackgroundTrans 0x200 vTab6_Text,Tab 6
		
		Gui,3:Show,% "x" This.W-300 " y0 w300 h" This.H
		This.Create_Window_3_Tabs()
	}
	Inner_Window(){
		Gui,4:+AlwaysOnTop -DPIScale -Caption +Parent1 +LastFound 
		Gui,4:Color,004444,444444
		Gui,4:Font,cWhite s10 q5, Segoe UI
		Gui,4:Show,% "x0 y40 w" This.W " h" This.H-50
	}
	Create_Window_2_Tabs(){   ;Tabs 1 - 3
		global
		; Tab 1
		;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		
		Gui,5:+Parent2 -Caption -DPIScale +AlwaysOnTop 
		Gui,5:Color,333333,444444
		Gui,5:Font,cWhite s10 q5, Segoe UI
		
		Gui,5:Add,Text,x10 y30 w70 r1,Background Color
		Gui,5:Add,Edit,x+10 yp w100 r1 vBitmapBackgroundColor gChange_Bitmap_Background_Color,004444
		
		Gui,5:Add,Text,x10 y+50 w267 r2 Border Center ,New Bitmap 
		
		Gui,5:Add,Text,x5 y+10 w50 r1 ,Name :
		Gui,5:Add,Edit,x+5 yp w200 r1 Center -E0x200 +Border ReadOnly vNew_Bitmap_Name,1
		
		
		Gui,5:Add,Text,x5 y+10 w40 r1 ,X :
		Gui,5:Add,Edit,x+10 yp w140 r1 Center Number -E0x200 +Border vNew_Bitmap_X,% Default_Values.Default_Bitmap_X
		Gui,5:Add,Text,x5 y+10 w40 r1 ,Y :
		Gui,5:Add,Edit,x+10 yp w140 r1 Center Number -E0x200 +Border vNew_Bitmap_Y,% Default_Values.Default_Bitmap_Y
		Gui,5:Add,Text,x5 y+10 w40 r1 ,W :
		Gui,5:Add,Edit,x+10 yp w140 r1 Center Number -E0x200 +Border vNew_Bitmap_W,% Default_Values.Default_Bitmap_W
		Gui,5:Add,Text,x5 y+10 w40 r1 ,H :
		Gui,5:Add,Edit,x+10 yp w140 r1 Center Number -E0x200 +Border vNew_Bitmap_H,% Default_Values.Default_Bitmap_H
		
		Gui,5:Add,Text,x5 y+10 w120 r1 ,Smoothing :
		Gui,5:Add,Edit,x+10 yp w70 r1 Limit1 Center Number -E0x200 +Border vNew_Bitmap_Smoothing,% Default_Values.Default_Bitmap_Smoothing
		
		Gui,5:Add,Button,x20 y+10 w247 r1 -Theme gAdd_New_Bitmap,Add New Bitmap
		
		Gui,5:Show,x5 y50 w287 h640
		
		; Tab 2
		;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		Gui,6:+Parent2 -Caption -DPIScale +AlwaysOnTop 
		Gui,6:Color,333333,444444
		Gui,6:Font,cWhite s10 q5, Segoe UI
		Gui,6:Add,ListBox,x5 y10 w280 r10 -Theme vList_Of_Saved_Bitmaps,% Saved_Bitmap_List
		
		Gui,6:Add,Button,x5 y+10 w280 r1 -Theme gTest_Load,Load Bitmap
		
		Gui,6:Add,Button,x5 y+20 w280 r1 -Theme gClip_Bitmap,Clipboard Bitmap
		
		Gui,6:Add,CheckBox,x10 y+100 gUnlock_Delete_Bitmap,Unlock
		
		Gui,6:Add,Button,x10 y+10 w267 r1 -Theme Disabled vDelete_Bitmap_Button gDelete_Bitmap,Delete Bitmap
		
		
		Gui,6:Show,Hide x5 y50 w287 h640
		; Tab 3
		;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		Gui,7:+Parent2 -Caption -DPIScale +AlwaysOnTop 
		Gui,7:Color,333333,444444
		Gui,7:Font,cWhite s10 q5, Segoe UI
		Gui,7:Add,Text,cLime x10 y10 w267 r3 Center Border vDisplay_Current_Bitmap_Name ,`nActive Bitmap : %Active_Bitmap% 
		Gui,7:Add,ListBox,x10 y+20 w267 r10 -Theme vList_Of_Existing_Saves gDump_Name_In_Name_To_Save_Edit,% Saved_Bitmap_List
		Gui,7:Submit,NoHide
		Gui,7:Add,Text,x10 y+20 w100 r1,Name :
		Gui,7:Add,Edit,x10 y+10 w267 r1 -E0x200 +Border vName_To_Save_Files,% List_Of_Existing_Saves
		
		Gui,7:Add,Button,x10 y+20 w267 r1 -Theme gSave_Code,Save Bitmap
		Gui,7:Add,Button,x10 y+10 w267 r1 -Theme gSave_PNG,Save PNG
		
		
		;Added in update 0.1.7
		;-------------------------------------
		Gui,7:Add,Progress,x20 y+50 w200 h30 BackgroundBlack c880000 vSave_Progress,0
		;-----------------------------------
		Gui,7:Show,Hide x5 y50 w287 h640
	}
	Create_Window_3_Tabs(){
		global
		Gui,8:+Parent3 -Caption -DPIScale +AlwaysOnTop 
		Gui,8:Color,333333,444444
		Gui,8:Font,cWhite s10 q5, Segoe UI
		Gui,8:Add,ListBox,x5 y0 w170 r15 -Theme AltSubmit vCurrent_Elements gSwitch_Active_Element,% Element_List
		Gui,8:Add,Checkbox,x+10 yp Checked -Theme vAuto_Draw gSet_Auto_Draw,Auto Draw
		Gui,8:Add,Button,xp y+5 w100 h20 -Theme gForce_Draw,Draw
		Gui,8:Add,Button,xp y+5 w45 h20 -Theme vReOrder_Up gReOrder_Elements,Up
		Gui,8:Add,Button,x+10 yp w45 h20 -Theme vReOrder_Down gReOrder_Elements,Down
		Gui,8:Add,Checkbox,xp-55 y+5 gUnlock_Element_Remove,Unlock
		Gui,8:Add,Button,xp y+5 w100 h20 -Theme Disabled vElement_Remove_Button gRemove_Element,Remove
		Gui,8:Add,Button,xp y+10 w100 h25 -Theme gClone_Element,Clone
		
		This.Create_Tab_4_Element_Window()
		Gui,8:Show,x5 y50 w287 h640
		;---------------------------------------------------------------------
		Gui,9:+Parent3 -Caption -DPIScale +AlwaysOnTop 
		Gui,9:Color,333333,444444
		Gui,9:Font,cWhite s8 q5, Segoe UI
		
		Gui,9:Add,Text,x10 y0 w267 h22 Center Border,Bitmap Defaults
		;-------------------------------Bitmap Defaults
		Gui,9:Add,Text,x10 y+5 w40 h20 ,X :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Bitmap_X gSubmit_Defaults,% Default_Values.Default_Bitmap_X
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,Y :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Bitmap_Y gSubmit_Defaults,% Default_Values.Default_Bitmap_Y
		
		Gui,9:Add,Text,x10 y+5 w40 h20 ,W :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Bitmap_W gSubmit_Defaults,% Default_Values.Default_Bitmap_W
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,H :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Bitmap_H gSubmit_Defaults,% Default_Values.Default_Bitmap_H
		
		Gui,9:Add,Text,x10 y+5 w80 h20 ,Smoothing :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Bitmap_Smoothing gSubmit_Defaults,% Default_Values.Default_Bitmap_Smoothing
		
		Gui,9:Add,Text,x10 y+5 w267 h22 Center Border,Element Defaults
		;-------------------------------Element Defaults
		Gui,9:Add,Text,x10 y+5 w40 h20 ,W :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_W gSubmit_Defaults,% Default_Values.Default_Element_W
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,H :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_H gSubmit_Defaults,% Default_Values.Default_Element_H
		
		Gui,9:Add,Text,x10 y+5 w40 h20 ,X :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_X gSubmit_Defaults,% Default_Values.Default_Element_X
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,Y :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Y gSubmit_Defaults,% Default_Values.Default_Element_Y
		
		Gui,9:Add,Text,x10 y+5 w40 h20 ,X2 :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_X2 gSubmit_Defaults,% Default_Values.Default_Element_X2
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,Y2 :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Y2 gSubmit_Defaults,% Default_Values.Default_Element_Y2
		
		Gui,9:Add,Text,x10 y+5 w40 h20 ,X3 :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_X3 gSubmit_Defaults,% Default_Values.Default_Element_X3
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,Y3 :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Y3 gSubmit_Defaults,% Default_Values.Default_Element_Y3
		
		Gui,9:Add,Text,x10 y+5 w40 h20 ,X4 :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_X4 gSubmit_Defaults,% Default_Values.Default_Element_X4
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,Y4 :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Y4 gSubmit_Defaults,% Default_Values.Default_Element_Y4
		
		Gui,9:Add,Text,x10 y+5 w60 h20 ,Alpha :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Alpha gSubmit_Defaults,% Default_Values.Default_Element_Alpha
		Gui,9:Add,Text,x+10 yp+2 w60 h20 ,Color :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Color gSubmit_Defaults,% Default_Values.Default_Element_Color
		
		Gui,9:Add,Text,x10 y+5 w60 h20 ,Alpha2 :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Alpha2 gSubmit_Defaults,% Default_Values.Default_Element_Alpha2
		Gui,9:Add,Text,x+10 yp+2 w60 h20 ,Color2 :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Color2 gSubmit_Defaults,% Default_Values.Default_Element_Color2
		
		Gui,9:Add,Text,x3 y+5 w55 h20 ,Hatch :
		Gui,9:Add,Edit,x+0 yp-2 w30 h20 -E0x200 Border Center vDefault_Element_Hatch gSubmit_Defaults,% Default_Values.Default_Element_Hatch
		Gui,9:Add,Text,x+3 yp+2 w55 h20 ,Radius :
		Gui,9:Add,Edit,x+0 yp-2 w30 h20 -E0x200 Border Center vDefault_Element_Radius gSubmit_Defaults,% Default_Values.Default_Element_Radius
		Gui,9:Add,Text,x+3 yp+2 w75 h20 ,Thickness :
		Gui,9:Add,Edit,x+0 yp-2 w30 h20 -E0x200 Border Center vDefault_Element_Thickness gSubmit_Defaults,% Default_Values.Default_Element_Thickness
		
		Gui,9:Add,Text,x5 y+5 w90 h20 ,Start Angle :
		Gui,9:Add,Edit,x+0 yp-2 w40 h20 -E0x200 Border Center vDefault_Element_Start_Angle gSubmit_Defaults,% Default_Values.Default_Element_Start_Angle
		Gui,9:Add,Text,x+10 yp+2 w100 h20 ,Sweep Angle :
		Gui,9:Add,Edit,x+0 yp-2 w40 h20 -E0x200 Border Center vDefault_Element_End_Angle gSubmit_Defaults,% Default_Values.Default_Element_End_Angle
		
		Gui,9:Add,Text,x10 y+5 w45 h20 ,Text :
		Gui,9:Add,Edit,x+0 yp-2 w90 h20 -E0x200 Border Center vDefault_Element_Text gSubmit_Defaults,% Default_Values.Default_Element_Text
		Gui,9:Add,Text,x+5 yp+2 w45 h20 ,Font :
		Gui,9:Add,Edit,x+0 yp-2 w90 h20 -E0x200 Border Center vDefault_Element_Font gSubmit_Defaults,% Default_Values.Default_Element_Font
		
		Gui,9:Add,Text,x10 y+5 w95 h20 ,Text Options :
		Gui,9:Add,Edit,x+0 yp-2 w180 h20 -E0x200 Border vDefault_Element_Options gSubmit_Defaults,% Default_Values.Default_Element_Options
		
		Gui,9:Add,Text,x10 y+5 w65 h20 ,Hidden :
		Gui,9:Add,Edit,x+0 yp-2 w40 h20 -E0x200 Border Center Limit1 Number vDefault_Element_Hidden gSubmit_Defaults,% Default_Values.Default_Element_Hidden
		Gui,9:Add,Text,x+15 yp+2 w95 h20 ,Brush Type :
		Gui,9:Add,Edit,x+0 yp-2 w40 h20 -E0x200 Border Center Limit1 Number vDefault_Element_Brush_Type gSubmit_Defaults,% Default_Values.Default_Element_Brush_Type
		
		Gui,9:Add,Text,x10 y+5 w90 h20 ,Polygon List :
		Gui,9:Add,Edit,x+0 yp-2 w180 h20 -E0x200 Border Center vDefault_Element_Polygon_List gSubmit_Defaults,% Default_Values.Default_Element_Polygon_List
		
		Gui,9:Add,Text,x10 y+5 w90 h20 ,Lines List :
		Gui,9:Add,Edit,x+0 yp-2 w180 h20 -E0x200 Border Center vDefault_Element_Lines_List gSubmit_Defaults,% Default_Values.Default_Element_Lines_List
		
		Gui,9:Add,Text,x10 y+5 w267 h22 Center Border,Line Brush
		
		Gui,9:Add,Text,x10 y+5 w25 h20 ,X1 :
		Gui,9:Add,Edit,x+0 yp-2 w40 h20 -E0x200 Border Center vDefault_Element_Line_Brush_X1 gSubmit_Defaults,% Default_Values.Default_Element_Line_Brush_X1
		Gui,9:Add,Text,x+5 yp+2 w25 h20 ,Y1 :
		Gui,9:Add,Edit,x+0 yp-2 w40 h20 -E0x200 Border Center vDefault_Element_Line_Brush_Y1 gSubmit_Defaults,% Default_Values.Default_Element_Line_Brush_Y1
		Gui,9:Add,Text,x+5 yp+2 w25 h20 ,X2 :
		Gui,9:Add,Edit,x+0 yp-2 w40 h20 -E0x200 Border Center vDefault_Element_Line_Brush_X2 gSubmit_Defaults,% Default_Values.Default_Element_Line_Brush_X2
		Gui,9:Add,Text,x+5 yp+2 w25 h20 ,Y2 :
		Gui,9:Add,Edit,x+0 yp-2 w40 h20 -E0x200 Border Center vDefault_Element_Line_Brush_Y2 gSubmit_Defaults,% Default_Values.Default_Element_Line_Brush_Y2
		
		Gui,9:Add,Text,x10 y+5 w100 h20 ,Wrap Mode :
		Gui,9:Add,Edit,x+10 yp-2 w40 h20 -E0x200 Border Center Limit1 Number vDefault_Element_Line_Brush_Wrap_Mode gSubmit_Defaults,% Default_Values.Default_Element_Line_Brush_Wrap_Mode
		
		Gui,9:Add,Text,x10 y+5 w267 h22 Center Border,Gradient Brush
		
		Gui,9:Add,Text,x10 y+5 w40 h20 ,X :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Grade_Brush_X gSubmit_Defaults,% Default_Values.Default_Element_Grade_Brush_X
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,Y :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Grade_Brush_Y gSubmit_Defaults,% Default_Values.Default_Element_Grade_Brush_Y
		
		Gui,9:Add,Text,x10 y+5 w40 h20 ,W :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Grade_Brush_W gSubmit_Defaults,% Default_Values.Default_Element_Grade_Brush_W
		Gui,9:Add,Text,x+10 yp+2 w40 h20 ,H :
		Gui,9:Add,Edit,x+10 yp-2 w60 h20 -E0x200 Border Center vDefault_Element_Grade_Brush_H gSubmit_Defaults,% Default_Values.Default_Element_Grade_Brush_H
		
		Gui,9:Add,Text,x5 y+5 w150 h20 ,Wrap Mode :
		Gui,9:Add,Edit,x+0 yp-2 w30 h20 -E0x200 Border Center Limit1 Number vDefault_Element_Grade_Brush_Wrap_Mode gSubmit_Defaults,% Default_Values.Default_Element_Grade_Brush_Wrap_Mode
		Gui,9:Add,Text,x5 y+5 w150 h20 ,Linear Gradient Mode :
		Gui,9:Add,Edit,x+0 yp-2 w30 h20 -E0x200 Border Center Limit1 Number vDefault_Element_Grade_Brush_LinearGradientMode gSubmit_Defaults,% Default_Values.Default_Element_Grade_Brush_LinearGradientMode
		
		Gui,9:Add,Button,x+10 yp-10 w100 h30 -Theme gSave_Defaults,Save
		
		Gui,9:Show,Hide x5 y50 w287 h640
		Gui,9:Submit,NoHide
		;---------------------------------------------------------------------
		Gui,10:+Parent3 -Caption -DPIScale +AlwaysOnTop 
		Gui,10:Color,333333,444444
		Gui,10:Font,cWhite s8 q5, Segoe UI
		Gui,10:Add,DDL,x10 y100 w270 r10 -Theme,Credits||Speed Master- Code Refactor / extra hotkeys|
		;~ Gui,10:Add,Button,x10 y200 w200 h30 -Theme, This is Tab 6
		Gui,10:Show,Hide x5 y50 w287 h640
	}
	Create_Tab_4_Element_Window(){
		Gui,12:+Parent8 -Caption -DPIScale +AlwaysOnTop 
		Gui,12:Color,333333,444444
		Gui,12:Show,x0 y260 w287 h380
	}
	Create_Element_Control_Window(){
		Gui,11:+Parent1 -Caption -DPIScale +AlwaysOnTop 
		Gui,11:Color,333333,444444
		Gui,11:Add,Progress,x0 y0 w250 h3 Background880000
		Gui,11:Add,Progress,x0 y0 w3 h200 Background880000
		Gui,11:Add,Progress,x247 y0 w3 h200 Background880000
		
		Gui,11:Show,x780 y500 w250 h200
	}
	Create_Bitmap_Control_Panel(){
		Gui,16:+Parent1 -Caption -DPIScale +AlwaysOnTop
		Gui,16:Color,333333,444444
		Gui,16:Font,cWhite s10 q5, Segoe UI
		Gui,16:Add,Progress,x0 y0 w350 h3 Background880000
		Gui,16:Add,Progress,x0 y0 w3 h200 Background880000
		Gui,16:Add,Progress,x347 y0 w3 h200 Background880000
		Gui,16:Show,x320 y500 w350 h200
	}
	Setup_Gdip(){
		This.Token:=Gdip_Startup()
		This.HWND:= WinExist()
	}
	Setup_DC(obj){
		obj.hdc1:= GetDC(This.HWND)
		obj.hdc2:=CreateCompatibleDC()
		obj.hbm:=CreateDIBSection(obj.W,obj.H)
		obj.obm:= SelectObject(obj.hdc2,obj.hbm)
		obj.G:= Gdip_GraphicsFromHDC(obj.hdc2)
	}
	Resize_DC(obj,w,h){
		obj.hdc1:= GetDC(This.HWND)
		obj.hdc2:=CreateCompatibleDC()
		obj.hbm:=CreateDIBSection(W,H)
		obj.obm:= SelectObject(obj.hdc2,obj.hbm)
		obj.G:= Gdip_GraphicsFromHDC(obj.hdc2)
	}
}

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;    Bitmap Class
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class BitMap_Class	{
	__New(x,y,w,h,smoothing,Name,Raster:=""){
		global
		This.X:=x
		This.Y:=y
		This.W:=w
		This.H:=h
		This.Name:=Name
		This.Zoom:=1.00
		This.Bitmap_Elements:=[]
		Windows.Setup_DC(This)
		This.Smoothing:=smoothing
		This.Raster:=Raster
		This.Create_BitMap()
		Gui,4:Add,Text,% "x" This.X " y" This.Y " w" This.W " h" This.H " gMove_Graphics v" This.Name 
		This.move()
	}
	Zoom_Bitmap(){
		Windows.Resize_DC(This,This.W*This.Zoom,This.H*This.Zoom)
		GuiControl,4:Move,% This.Name,% "w" This.W*This.Zoom " h" This.H*This.Zoom
	}
	move(){
		Gdip_GraphicsClear(This.G)
		Gdip_DrawImage(This.G,This.Bitmap,0,0,This.W*This.Zoom,This.H*This.Zoom)
		BitBlt(This.hdc1 , This.X , This.Y , This.W*This.Zoom , This.H*This.Zoom , This.hdc2 ,0,0,This.Raster) 
	}
	Create_BitMap(Save_Flag:=0){
		if(Save_Flag=0){
			;----------------------------------------------
			;Fix memory leak
			Gdip_DisposeImage(This.Bitmap)
			This.Bitmap:=""
			Gdip_DeleteGraphics( This.Bitmap_G )
			This.Bitmap_G:=""
			;----------------------------------------------
			This.Bitmap:=Gdip_CreateBitmap(This.W,This.H),This.Bitmap_G := Gdip_GraphicsFromImage(This.Bitmap),Gdip_SetSmoothingMode(This.Bitmap_G,This.Smoothing)
		}
		else if(Save_Flag=1){
			FileDelete,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Bitmap_Settings:="HB_BITMAP_MAKER(){`n`t;Bitmap Created Using: HB Bitmap Maker`n`tpBitmap:=Gdip_CreateBitmap( " This.W " , " This.H " ) `n`tG := Gdip_GraphicsFromImage( pBitmap )`n`tGdip_SetSmoothingMode( G , " This.Smoothing " )"
			FileAppend,%Bitmap_Settings%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Bitmap_Settings:=""
		}
	}
	Create_Brush(index,Save_Flag:=0){
		if(Save_Flag=0){
			if(This.Bitmap_Elements[index].Brush_Type=1)
				This.Brush1:=New_Brush(This.Bitmap_Elements[index].Color,This.Bitmap_Elements[index].Alpha)
			else if(This.Bitmap_Elements[index].Brush_Type=2)
				This.Brush1:=Gdip_BrushCreateHatch("0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color,"0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2 , This.Bitmap_Elements[index].Hatch)
			else if(This.Bitmap_Elements[index].Brush_Type=3)
				This.Brush1:=Gdip_CreateLineBrush(This.Bitmap_Elements[index].Line_Brush_X1, This.Bitmap_Elements[index].Line_Brush_Y1, This.Bitmap_Elements[index].Line_Brush_X2, This.Bitmap_Elements[index].Line_Brush_Y2, "0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color,"0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2, This.Bitmap_Elements[index].Line_Brush_Wrap_Mode)
			else if(This.Bitmap_Elements[index].Brush_Type=4)
				This.Brush1:=Gdip_CreateLineBrushFromRect(This.Bitmap_Elements[index].Grade_Brush_X, This.Bitmap_Elements[index].Grade_Brush_Y, This.Bitmap_Elements[index].Grade_Brush_W, This.Bitmap_Elements[index].Grade_Brush_H,"0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color,"0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2, This.Bitmap_Elements[index].Grade_Brush_LinearGradientMode, This.Bitmap_Elements[index].Grade_Brush_Wrap_Mode)
		}else if(Save_Flag=1){
			if(This.Bitmap_Elements[index].Brush_Type=1)
				Brush:="`n`tBrush := Gdip_BrushCreateSolid( ""0x" This.Bitmap_Elements[index].Alpha This.Bitmap_Elements[index].Color """ )"
			else if(This.Bitmap_Elements[index].Brush_Type=2)
				Brush:="`n`tBrush := Gdip_BrushCreateHatch( ""0x" This.Bitmap_Elements[index].Alpha This.Bitmap_Elements[index].Color """ , ""0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2 """ , " This.Bitmap_Elements[index].Hatch " )"
			else if(This.Bitmap_Elements[index].Brush_Type=3)
				Brush:="`n`tBrush := Gdip_CreateLineBrush( " This.Bitmap_Elements[index].Line_Brush_X1 " , " This.Bitmap_Elements[index].Line_Brush_Y1 " , " This.Bitmap_Elements[index].Line_Brush_X2 " , " This.Bitmap_Elements[index].Line_Brush_Y2 " , ""0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color """ , ""0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2 """ , " This.Bitmap_Elements[index].Line_Brush_Wrap_Mode " )"
			else if(This.Bitmap_Elements[index].Brush_Type=4)
				Brush:="`n`tBrush := Gdip_CreateLineBrushFromRect( " This.Bitmap_Elements[index].Grade_Brush_X " , " This.Bitmap_Elements[index].Grade_Brush_Y " , " This.Bitmap_Elements[index].Grade_Brush_W " , " This.Bitmap_Elements[index].Grade_Brush_H " , ""0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color """ , ""0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2 """ , " This.Bitmap_Elements[index].Grade_Brush_LinearGradientMode " , " This.Bitmap_Elements[index].Grade_Brush_Wrap_Mode " )"
			if(This.Bitmap_Elements[index].Notes){
				Notes:="`n`t;" This.Bitmap_Elements[index].Notes
				FileAppend,%Notes%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
				Notes:=""
			}
			FileAppend,%Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Brush:=""
		}
	}
	Create_Pen(Index,Save_Flag){
		if(Save_Flag=0){
			if(This.Bitmap_Elements[index].Brush_Type=1){
				This.Pen1:=New_Pen(This.Bitmap_Elements[index].Color,This.Bitmap_Elements[index].Alpha,This.Bitmap_Elements[index].Thickness)
			}else if(This.Bitmap_Elements[index].Brush_Type=2){
				This.Brush1:=Gdip_BrushCreateHatch("0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color,"0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2 , This.Bitmap_Elements[index].Hatch)
				This.Pen1:=Gdip_CreatePenFromBrush(This.Brush1,This.Bitmap_Elements[index].Thickness)
				Gdip_DeleteBrush(This.Brush1)
			}else if(This.Bitmap_Elements[index].Brush_Type=3){
				This.Brush1:=Gdip_CreateLineBrush(This.Bitmap_Elements[index].Line_Brush_X1, This.Bitmap_Elements[index].Line_Brush_Y1, This.Bitmap_Elements[index].Line_Brush_X2, This.Bitmap_Elements[index].Line_Brush_Y2, "0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color,"0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2, This.Bitmap_Elements[index].Line_Brush_Wrap_Mode)
				This.Pen1:=Gdip_CreatePenFromBrush(This.Brush1,This.Bitmap_Elements[index].Thickness)
				Gdip_DeleteBrush(This.Brush1)
			}else if(This.Bitmap_Elements[index].Brush_Type=4){
				This.Brush1:=Gdip_CreateLineBrushFromRect(This.Bitmap_Elements[index].Grade_Brush_X, This.Bitmap_Elements[index].Grade_Brush_Y, This.Bitmap_Elements[index].Grade_Brush_W, This.Bitmap_Elements[index].Grade_Brush_H,"0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color,"0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2, This.Bitmap_Elements[index].Grade_Brush_LinearGradientMode, This.Bitmap_Elements[index].Grade_Brush_Wrap_Mode)
				This.Pen1:=Gdip_CreatePenFromBrush(This.Brush1,This.Bitmap_Elements[index].Thickness)
				Gdip_DeleteBrush(This.Brush1)
			}
		}else if(Save_Flag=1){
			if(This.Bitmap_Elements[index].Brush_Type=1){
				Pen:="`n`tPen := Gdip_CreatePen( ""0x" This.Bitmap_Elements[index].Alpha This.Bitmap_Elements[index].Color """ , " This.Bitmap_Elements[index].Thickness " )"
				Brush:=""
				Delete_Brush:=""
			}else if(This.Bitmap_Elements[index].Brush_Type=2){
				Brush:="`n`tBrush := Gdip_BrushCreateHatch( ""0x" This.Bitmap_Elements[index].Alpha This.Bitmap_Elements[index].Color """ , ""0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2 """ , " This.Bitmap_Elements[index].Hatch " )"
				Pen:="`n`tPen := Gdip_CreatePenFromBrush( Brush , " This.Bitmap_Elements[index].Thickness " )"
				Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			}else if(This.Bitmap_Elements[index].Brush_Type=3){
				Brush:="`n`tBrush := Gdip_CreateLineBrush( " This.Bitmap_Elements[index].Line_Brush_X1 " , " This.Bitmap_Elements[index].Line_Brush_Y1 " , " This.Bitmap_Elements[index].Line_Brush_X2 " , " This.Bitmap_Elements[index].Line_Brush_Y2 " , ""0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color """ , ""0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2 """ , " This.Bitmap_Elements[index].Line_Brush_Wrap_Mode " )"
				Pen:="`n`tPen := Gdip_CreatePenFromBrush( Brush , " This.Bitmap_Elements[index].Thickness " )"
				Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			}else if(This.Bitmap_Elements[index].Brush_Type=4){
				Brush:="`n`tBrush := Gdip_CreateLineBrushFromRect( " This.Bitmap_Elements[index].Grade_Brush_X " , " This.Bitmap_Elements[index].Grade_Brush_Y " , " This.Bitmap_Elements[index].Grade_Brush_W " , " This.Bitmap_Elements[index].Grade_Brush_H " , ""0x" This.Bitmap_Elements[index].Alpha  This.Bitmap_Elements[index].Color """ , ""0x"  This.Bitmap_Elements[index].Alpha2 This.Bitmap_Elements[index].Color2 """ , " This.Bitmap_Elements[index].Grade_Brush_LinearGradientMode " , " This.Bitmap_Elements[index].Grade_Brush_Wrap_Mode " )"
				Pen:="`n`tPen := Gdip_CreatePenFromBrush( Brush , " This.Bitmap_Elements[index].Thickness " )"
				Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			}
			FileAppend,%Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Brush:=""
			Pen:=""
			Delete_Brush:=""
		}
	}
	Fill_Rectangle(index,Save_Flag:=0){
		This.Create_Brush(index,Save_Flag)
		if(Save_Flag=0){
			Fill_Box(This.Bitmap_G,This.Brush1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H)
			Gdip_DeleteBrush(This.Brush1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_FillRectangle( G , Brush , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , "This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " )"
			Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Brush:=""
			Temp:=""
		}
	}
	Fill_Rounded_Rectangle(index,Save_Flag:=0){
		This.Create_Brush(index,Save_Flag)
		if(Save_Flag=0){
			Gdip_FillRoundedRectangle(This.Bitmap_G,This.Brush1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H, This.Bitmap_Elements[index].Radius)
			Gdip_DeleteBrush(This.Brush1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_FillRoundedRectangle( G , Brush , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " , " This.Bitmap_Elements[index].Radius " )"
			Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Brush:=""
			Temp:=""
		}
	}
	Fill_Circle(index,Save_Flag:=0){
		This.Create_Brush(index,Save_Flag)
		if(Save_Flag=0){
			Gdip_FillEllipse(This.Bitmap_G,This.Brush1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H)
			Gdip_DeleteBrush(This.Brush1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_FillEllipse( G , Brush , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " )"
			Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Brush:=""
			Temp:=""
		}
	}
	Fill_Pie(index,Save_Flag:=0){
		This.Create_Brush(index,Save_Flag)
		if(Save_Flag=0){
			Gdip_FillPie(This.Bitmap_G,This.Brush1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H, This.Bitmap_Elements[index].Start_Angle, This.Bitmap_Elements[index].End_Angle)
			Gdip_DeleteBrush(This.Brush1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_FillPie( G , Brush , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " , " This.Bitmap_Elements[index].Start_Angle " , " This.Bitmap_Elements[index].End_Angle " )"
			Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Brush:=""
			Temp:=""
		}
	}
	Fill_Polygon(index,Save_Flag:=0){
		;~ ToolTip,% This.Bitmap_Elements[index].Polygon_List " here"
		This.Create_Brush(index,Save_Flag)
		if(Save_Flag=0){
			Gdip_FillPolygon(This.Bitmap_G,This.Brush1, This.Bitmap_Elements[index].Polygon_List) ;, FillMode=0)
			Gdip_DeleteBrush(This.Brush1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_FillPolygon( G , Brush , """ This.Bitmap_Elements[index].Polygon_List """ )"
			Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Brush:=""
			Temp:=""
		}
		
	}
	Text(Index,Save_Flag:=0){
		This.Create_Brush(index,Save_Flag)
		if(Save_Flag=0){
			Gdip_TextToGraphics(This.Bitmap_G, This.Bitmap_Elements[index].Text , This.Bitmap_Elements[index].Options " c" This.Brush1 " x" This.Bitmap_Elements[index].X " y" This.Bitmap_Elements[index].Y , This.Bitmap_Elements[index].Font , This.Bitmap_Elements[index].W , This.Bitmap_Elements[index].H ) 
		}else if(Save_Flag=1){
			if(This.Bitmap_Elements[index].Notes){
				Notes:="`n`t;" This.Bitmap_Elements[index].Notes
				FileAppend,%Notes%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
				Notes:=""
			}
			Temp:="`n`tGdip_TextToGraphics( G , """ This.Bitmap_Elements[index].Text """ , """ This.Bitmap_Elements[index].Options " c"" Brush "" x" This.Bitmap_Elements[index].X " y" This.Bitmap_Elements[index].Y """ , """ This.Bitmap_Elements[index].Font """ , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " )" 
			Delete_Brush:="`n`tGdip_DeleteBrush( Brush )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Brush%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Brush:=""
			Temp:=""
		}
	}
	Draw_Rectangle(Index,Save_Flag:=0){
		This.Create_Pen(Index,Save_Flag)
		if(Save_Flag=0){
			Gdip_DrawRectangle(This.Bitmap_G,This.Pen1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H)
			Gdip_DeletePen(This.Pen1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_DrawRectangle( G , Pen , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " )"
			Delete_Pen:="`n`tGdip_DeletePen( Pen )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Pen:=""
			Temp:=""
		}
	}
	Draw_Rounded_Rectangle(index,Save_Flag:=0){
		This.Create_Pen(Index,Save_Flag)
		if(Save_Flag=0){
			Gdip_DrawRoundedRectangle(This.Bitmap_G,This.Pen1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H, This.Bitmap_Elements[index].Radius)
			Gdip_DeletePen(This.Pen1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_DrawRoundedRectangle( G , Pen , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " , " This.Bitmap_Elements[index].Radius " )"
			Delete_Pen:="`n`tGdip_DeletePen( Pen )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Pen:=""
			Temp:=""
		}
	}
	Draw_Circle(index,Save_Flag:=0){
		This.Create_Pen(Index,Save_Flag)
		if(Save_Flag=0){
			Gdip_DrawEllipse(This.Bitmap_G,This.Pen1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H)
			Gdip_DeletePen(This.Pen1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_DrawEllipse( G , Pen , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " )"
			Delete_Pen:="`n`tGdip_DeletePen( Pen )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Pen:=""
			Temp:=""
		}
	}
	Draw_Line(index,Save_Flag:=0){
		This.Create_Pen(Index,Save_Flag)
		if(Save_Flag=0){
			Gdip_DrawLine(This.Bitmap_G,This.Pen1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].X2,This.Bitmap_Elements[index].Y2)
			Gdip_DeletePen(This.Pen1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_DrawLine( G , Pen , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].X2 " , " This.Bitmap_Elements[index].Y2 " )"
			Delete_Pen:="`n`tGdip_DeletePen( Pen )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Pen:=""
			Temp:=""
		}	
	}
	Draw_Lines(index,Save_Flag:=0){
		This.Create_Pen(Index,Save_Flag)
		if(Save_Flag=0){
			Gdip_DrawLines(This.Bitmap_G,This.Pen1,This.Bitmap_Elements[index].Lines_List)
			Gdip_DeletePen(This.Pen1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_DrawLines( G , Pen , """ This.Bitmap_Elements[index].Lines_List """ )"
			Delete_Pen:="`n`tGdip_DeletePen( Pen )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Pen:=""
			Temp:=""
		}	
	}
	Draw_Arc(index,Save_Flag:=0){
		This.Create_Pen(Index,Save_Flag)
		if(Save_Flag=0){
			Gdip_DrawArc(This.Bitmap_G,This.Pen1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H, This.Bitmap_Elements[index].Start_Angle, This.Bitmap_Elements[index].End_Angle)
			Gdip_DeletePen(This.Pen1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_DrawArc( G , Pen , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " , " This.Bitmap_Elements[index].Start_Angle " , " This.Bitmap_Elements[index].End_Angle " )"
			Delete_Pen:="`n`tGdip_DeletePen( Pen )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Pen:=""
			Temp:=""
		}	
	}
	Draw_Pie(index,Save_Flag:=0){
		This.Create_Pen(Index,Save_Flag)
		if(Save_Flag=0){
			Gdip_DrawPie(This.Bitmap_G,This.Pen1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y,This.Bitmap_Elements[index].W,This.Bitmap_Elements[index].H, This.Bitmap_Elements[index].Start_Angle, This.Bitmap_Elements[index].End_Angle)
			Gdip_DeletePen(This.Pen1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_DrawPie( G , Pen , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].W " , " This.Bitmap_Elements[index].H " , " This.Bitmap_Elements[index].Start_Angle " , " This.Bitmap_Elements[index].End_Angle " )"
			Delete_Pen:="`n`tGdip_DeletePen( Pen )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Pen:=""
			Temp:=""
		}	
	}
	Draw_Bezier(index,Save_Flag:=0){
		This.Create_Pen(Index,Save_Flag)
		if(Save_Flag=0){
			Gdip_DrawBezier(This.Bitmap_G,This.Pen1,This.Bitmap_Elements[index].X,This.Bitmap_Elements[index].Y, This.Bitmap_Elements[index].x2, This.Bitmap_Elements[index].y2, This.Bitmap_Elements[index].x3, This.Bitmap_Elements[index].y3, This.Bitmap_Elements[index].x4, This.Bitmap_Elements[index].y4)
			Gdip_DeletePen(This.Pen1)
			This.Move()
		}else if(Save_Flag=1){
			Temp:="`n`tGdip_DrawBezier( G , Pen , " This.Bitmap_Elements[index].X " , " This.Bitmap_Elements[index].Y " , " This.Bitmap_Elements[index].x2 " , " This.Bitmap_Elements[index].y2 " , " This.Bitmap_Elements[index].x3 " , " This.Bitmap_Elements[index].y3 " , " This.Bitmap_Elements[index].x4 " , " This.Bitmap_Elements[index].y4 " )"
			Delete_Pen:="`n`tGdip_DeletePen( Pen )"
			FileAppend,%Temp%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			FileAppend,%Delete_Pen%,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%Name_To_Save_Files%.txt
			Delete_Pen:=""
			Temp:=""
		}		
	}
}

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;    Bitmap Control Panel Class
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Bitmap_Info_Control_Panel	{
	Create_Bitmap_Control_Panel(){
		Gui,17:Destroy
		Gui,17:+Parent16 -Caption +AlwaysOnTop -DPIScale 
		Gui,17:Color,333333,444444
		Gui,17:Font,cWhite s8 q5, Segoe UI
	}
	Show_Bitmap_Control_Panel(){
		Gui,17:Show,x3 y3 w346 h197 
	}
	Bitmap_Position_Controls(){
		global
		Gui,17:Add,Button,x45 y10 w60 h25 -Theme Disabled vBit_Up gMove_Bitmap,Up
		Gui,17:Add,Button,x10 y+5 w60 h25 -Theme Disabled vBit_Left gMove_Bitmap,Left
		Gui,17:Add,Button,x+10 yp w60 h25 -Theme Disabled vBit_Right gMove_Bitmap,Right
		Gui,17:Add,Button,x45 y+5 w60 h25 -Theme Disabled vBit_Down gMove_Bitmap,Down
		
		Gui,17:Add,Button,x160 y40 w80 h25 -Theme Disabled vBit_Minus_Width gAdjust_Bitmap_Width_Height,- Width
		Gui,17:Add,Button,x+5 yp w80 h25 -Theme Disabled vBit_Plus_Width gAdjust_Bitmap_Width_Height,+ Width
		Gui,17:Add,Button,x160 y+10 w80 h25 -Theme Disabled vBit_Minus_Height gAdjust_Bitmap_Width_Height,- Height
		Gui,17:Add,Button,x+5 yp w80 h25 -Theme Disabled vBit_Plus_Height gAdjust_Bitmap_Width_Height,+ Height
	}
	Bitmap_Position_Details(obj){
		global
		Gui,17:Add,Text,x10 y+10 w25 h20 0x200,X :
		Gui,17:Add,Edit,x+5 yp w40 h20 Center Disabled -E0x200 vSet_Bit_X gSubmit_17,% obj.X
		Gui,17:Add,Text,x+10 yp w25 h20 0x200,Y :
		Gui,17:Add,Edit,x+5 yp w40 h20 Center Disabled -E0x200 vSet_Bit_Y gSubmit_17,% obj.Y
		Gui,17:Add,Text,x+10 yp w25 h20 0x200,W :
		Gui,17:Add,Edit,x+5 yp w40 h20 Center Disabled -E0x200 vSet_Bit_W gSubmit_17,% obj.W
		Gui,17:Add,Text,x+10 yp w25 h20 0x200,H :
		Gui,17:Add,Edit,x+5 yp w40 h20 Center Disabled -E0x200 vSet_Bit_H gSubmit_17,% obj.H
	}
	Bitmap_Zoom(obj){
		global
		Gui,17:Add,Text,x10 y+10 w45 h20 0x200,Zoom :
		Gui,17:Add,DDL,x+10 yp w100 r10 -Theme Disabled vZoom_Level gSubmit_17,.25|.50|.75|1.00|1.25|1.50|1.75|2.00|3.00|4.00|5.00|6.00|7.00|8.00|9.00|10.00|15.00|20.00|
		GuiControl,17:Choose,Zoom_Level,% Bitmap_Array[Active_Bitmap].Zoom
	}
	Bitmap_Lock(){
		global
		Gui,17:Add,Checkbox,x170 y5 h25 vBitmap_Control_Lock gUnlock_Bitmap_Controls,Unlock
	}
	Bitmap_Smoothing(){
		global
		Gui,17:Add,Text,x180 y135 w80 h20 Border,Smoothing :
		Gui,17:Add,DDL,xp y+5 w140 r5 -Theme Disabled vBitmap_Smoothing gSubmit_17,0|1|2|3|4|
		GuiControl,17:Choose,Bitmap_Smoothing,% Bitmap_Array[Active_Bitmap].Smoothing+1
	}
}

Set_LineBrush_Positions(){
	isPressed:=0,Set:=0
	CoordMode,Mouse,Client
	While(!GetKeyState("Alt")){
		if(!Set&&!isPressed){
			MouseGetPos,tcx,tcy
			tcx:=floor((tcx-Bitmap_Array[Active_Bitmap].X)/Bitmap_Array[Active_Bitmap].Zoom)
			tcy:=floor((tcy-(Bitmap_Array[Active_Bitmap].Y+40))/Bitmap_Array[Active_Bitmap].Zoom)
			ToolTip,% "Press ""Shift"" to set a position`nPress ""ctrl"" to switch between sets`nPress ""Alt"" to finish`nCurrent Set: " Set+1 "`nX1: " tcx "   Y1: " tcy 
			if(GetKeyState("Shift")&&!isPressed){
				isPressed:=1
				Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Line_Brush_X1:=tcx
				Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Line_Brush_Y1:=tcy
				GuiControl,14:,Line_Brush_X1,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Line_Brush_X1
				GuiControl,14:,Line_Brush_Y1,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Line_Brush_Y1
			}else if(GetKeyState("ctrl")&&!isPressed){
				isPressed:=1
				Set:=1
			}
		}else if(Set&&!isPressed){
			MouseGetPos,tcx,tcy
			tcx:=floor((tcx-Bitmap_Array[Active_Bitmap].X)/Bitmap_Array[Active_Bitmap].Zoom)
			tcy:=floor((tcy-(Bitmap_Array[Active_Bitmap].Y+40))/Bitmap_Array[Active_Bitmap].Zoom)
			ToolTip,% "Press ""Shift"" to set a position`nPress ""ctrl"" to switch between sets`nPress ""Alt"" to finish`nCurrent Set: " Set+1 "`nX2: " tcx "   Y2: " tcy 
			if(GetKeyState("Shift")&&!isPressed){
				isPressed:=1
				Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Line_Brush_X2:=tcx
				Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Line_Brush_Y2:=tcy
				GuiControl,14:,Line_Brush_X2,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Line_Brush_X2
				GuiControl,14:,Line_Brush_Y2,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Line_Brush_Y2
			}else if(GetKeyState("ctrl")&&!isPressed){
				isPressed:=1
				Set:=0
			}
		}else if(isPressed&&!GetKeyState("Shift")&&!GetKeyState("ctrl")){
			isPressed:=0
		}
		if(GetKeyState("Up"))
			MouseMove,0,-1,,R
		else if(GetKeyState("Down"))
			MouseMove,0,1,,R
		else if(GetKeyState("Left"))
			MouseMove,-1,0,,R
		else if(GetKeyState("Right"))
			MouseMove,1,0,,R
	}
	ToolTip,
}

Set_GradeBrush_Positions(){
	isPressed:=0,Set:=0
	CoordMode,Mouse,Client
	While(!GetKeyState("Alt")){
		if(!Set&&!isPressed){
			MouseGetPos,tcx,tcy
			tcx:=floor((tcx-Bitmap_Array[Active_Bitmap].X)/Bitmap_Array[Active_Bitmap].Zoom)
			tcy:=floor((tcy-(Bitmap_Array[Active_Bitmap].Y+40))/Bitmap_Array[Active_Bitmap].Zoom)
			ToolTip,% "Press ""Shift"" to set a position`nPress ""ctrl"" to switch between sets`nPress ""Alt"" to finish`nCurrent Set: " Set+1 "`nX: " tcx "   Y: " tcy 
			if(GetKeyState("Shift")&&!isPressed){
				isPressed:=1
				Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_X:=tcx
				Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_Y:=tcy
				GuiControl,14:,Grade_Brush_X,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_X
				GuiControl,14:,Grade_Brush_Y,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_Y
				
			}else if(GetKeyState("ctrl")&&!isPressed){
				isPressed:=1
				Set:=1
			}
		}else if(Set&&!isPressed){
			MouseGetPos,tcx,tcy
			tcx:=floor((tcx-(Bitmap_Array[Active_Bitmap].X+Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_X))/Bitmap_Array[Active_Bitmap].Zoom)
			tcy:=floor((tcy-(Bitmap_Array[Active_Bitmap].Y+40+Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_Y))/Bitmap_Array[Active_Bitmap].Zoom)
			ToolTip,% "Press ""Shift"" to set a position`nPress ""ctrl"" to switch between sets`nPress ""Alt"" to finish`nCurrent Set: " Set+1 "`nW: " tcx "   H: " tcy 
			if(GetKeyState("Shift")&&!isPressed){
				isPressed:=1
				Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_W:=tcx
				Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_H:=tcy
				GuiControl,14:,Grade_Brush_W,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_W
				GuiControl,14:,Grade_Brush_H,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Grade_Brush_H
			}else if(GetKeyState("ctrl")&&!isPressed){
				isPressed:=1
				Set:=0
			}
		}else if(isPressed&&!GetKeyState("Shift")&&!GetKeyState("ctrl")){
			isPressed:=0
		}
		if(GetKeyState("Up"))
			MouseMove,0,-1,,R
		else if(GetKeyState("Down"))
			MouseMove,0,1,,R
		else if(GetKeyState("Left"))
			MouseMove,-1,0,,R
		else if(GetKeyState("Right"))
			MouseMove,1,0,,R
	}
	ToolTip,
}

Adjust_Bitmap_Width_Height(){
	if(A_GuiControl="Bit_Minus_Width"){
		if(GetKeyState("Shift")&&Bitmap_Array[Active_Bitmap].W>10){
			Bitmap_Array[Active_Bitmap].W-=10
		}else if(Bitmap_Array[Active_Bitmap].W>1){
			Bitmap_Array[Active_Bitmap].W-=1
		}
	}else if(A_GuiControl="Bit_Plus_Width"){
		if(GetKeyState("Shift")){
			Bitmap_Array[Active_Bitmap].W+=10
		}else	{
			Bitmap_Array[Active_Bitmap].W+=1
		}
	}else if(A_GuiControl="Bit_Minus_Height"){
		if(GetKeyState("Shift")&&Bitmap_Array[Active_Bitmap].H>10){
			Bitmap_Array[Active_Bitmap].H-=10
		}else if(Bitmap_Array[Active_Bitmap].H>1){
			Bitmap_Array[Active_Bitmap].H-=1
		}
	}else if(A_GuiControl="Bit_Plus_Height"){
		if(GetKeyState("Shift")){
			Bitmap_Array[Active_Bitmap].H+=10
		}else	{
			Bitmap_Array[Active_Bitmap].H+=1
		}
	}
	GuiControl,4:Move,% Bitmap_Array[Active_Bitmap].Name,% "w" Bitmap_Array[Active_Bitmap].W*Bitmap_Array[Active_Bitmap].Zoom " h" Bitmap_Array[Active_Bitmap].H*Bitmap_Array[Active_Bitmap].Zoom
	GuiControl,17:,Set_Bit_H,% Bitmap_Array[Active_Bitmap].H
	GuiControl,17:,Set_Bit_W,% Bitmap_Array[Active_Bitmap].W
	Bitmap_Array[Active_Bitmap].Zoom_Bitmap()
	if(Auto_Draw){
			SetTimer,Force_Draw,-10
		}
	Loop,% Bitmap_Array.Length()
			Bitmap_Array[A_Index].move()	
}

Move_Bitmap(){
	if(A_GuiControl="Bit_Up"){
		if(GetKeyState("Shift")){
			Bitmap_Array[Active_Bitmap].Y-=10
		}else	{
			Bitmap_Array[Active_Bitmap].Y-=1
		}
	}else if(A_GuiControl="Bit_Left"){
		if(GetKeyState("Shift")){
			Bitmap_Array[Active_Bitmap].X-=10
		}else	{
			Bitmap_Array[Active_Bitmap].X-=1
		}
	}else if(A_GuiControl="Bit_Right"){
		if(GetKeyState("Shift")){
			Bitmap_Array[Active_Bitmap].X+=10
		}else	{
			Bitmap_Array[Active_Bitmap].X+=1
		}
	}else if(A_GuiControl="Bit_Down"){
		if(GetKeyState("Shift")){
			Bitmap_Array[Active_Bitmap].Y+=10
		}else	{
			Bitmap_Array[Active_Bitmap].Y+=1
		}
	}
	GuiControl,4:Move,% Bitmap_Array[Active_Bitmap].Name,% "x" Bitmap_Array[Active_Bitmap].X " y" Bitmap_Array[Active_Bitmap].Y
	GuiControl,17:,Set_Bit_X,% Bitmap_Array[Active_Bitmap].X
	GuiControl,17:,Set_Bit_Y,% Bitmap_Array[Active_Bitmap].Y
	Loop,% Bitmap_Array.Length()
		Bitmap_Array[A_Index].move()
	if(Auto_Draw){
			SetTimer,Force_Draw,-10
		}
}

RePosition_Polygon_Element(){
	;~ ToolTip,Here
}

Add_New_Polygon_Point(){
	isPressed:=""
	CoordMode,Mouse,Client
	While(!GetKeyState("ctrl")){
		MouseGetPos,polyX,polyY
		ToolTip,% "Move your cursor to where you want to add the point and then press ""Shift"" `nPress ""Ctrl"" To Finish`n" floor((polyX-Bitmap_Array[Active_Bitmap].X)/Bitmap_Array[Active_Bitmap].Zoom) "`n" floor((polyY-(Bitmap_Array[Active_Bitmap].Y+40))/Bitmap_Array[Active_Bitmap].Zoom)
		If(GetKeyState("Shift")&&!isPressed){
			isPressed:=1
			MouseGetPos,polyX,polyY
			polyX-=Bitmap_Array[Active_Bitmap].X
			polyY-=(Bitmap_Array[Active_Bitmap].Y+40)
			polyX:=floor(polyX/Bitmap_Array[Active_Bitmap].Zoom)
			polyY:=floor(polyY/Bitmap_Array[Active_Bitmap].Zoom)
			Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Polygon_List.=polyX "," polyY "|"
			GuiControl,13:,Polygon_List,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Polygon_List
		}else if(!GetKeyState("Shift")&&isPressed){
			isPressed:=0
		}
		if(GetKeyState("Up"))
			MouseMove,0,-1,,R
		else if(GetKeyState("Down"))
			MouseMove,0,1,,R
		else if(GetKeyState("Left"))
			MouseMove,-1,0,,R
		else if(GetKeyState("Right"))
			MouseMove,1,0,,R
	}
	ToolTip,
	GuiControl,13:,Polygon_List,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Polygon_List
}

Add_New_Lines_Point(){
	isPressed:=""
	CoordMode,Mouse,Client
	While(!GetKeyState("ctrl")){
		MouseGetPos,polyX,polyY
		ToolTip,% "Move your cursor to where you want to add the point and then press ""Shift"" `nPress ""Ctrl"" To Finish`n" floor((polyX-Bitmap_Array[Active_Bitmap].X)/Bitmap_Array[Active_Bitmap].Zoom) "`n" floor((polyY-(Bitmap_Array[Active_Bitmap].Y+40))/Bitmap_Array[Active_Bitmap].Zoom)
		If(GetKeyState("Shift")&&!isPressed){
			isPressed:=1
			MouseGetPos,polyX,polyY
			polyX-=Bitmap_Array[Active_Bitmap].X
			polyY-=(Bitmap_Array[Active_Bitmap].Y+40)
			polyX:=floor(polyX/Bitmap_Array[Active_Bitmap].Zoom)
			polyY:=floor(polyY/Bitmap_Array[Active_Bitmap].Zoom)
			Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Lines_List.=polyX "," polyY "|"
			GuiControl,13:,Lines_List,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Lines_List
		}else if(!GetKeyState("Shift")&&isPressed){
			isPressed:=0
		}
		if(GetKeyState("Up"))
			MouseMove,0,-1,,R
		else if(GetKeyState("Down"))
			MouseMove,0,1,,R
		else if(GetKeyState("Left"))
			MouseMove,-1,0,,R
		else if(GetKeyState("Right"))
			MouseMove,1,0,,R
	}
	ToolTip,
	GuiControl,13:,Polygon_List,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Polygon_List
}

Clear_Points(){
	Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Lines_List:=""
	Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Polygon_List:=""
	GuiControl,13:,Lines_List,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Lines_List
	GuiControl,13:,Polygon_List,% Bitmap_Array[Active_Bitmap].BitMap_Elements[Active_Element].Polygon_List
}

Unlock_Bitmap_Controls(){
	GuiControlGet,Bitmap_Control_Lock,17:,Bitmap_Control_Lock
	if(Bitmap_Control_Lock){
		Guicontrol,17:Enable,Bit_Up
		Guicontrol,17:Enable,Bit_Down
		Guicontrol,17:Enable,Bit_Left
		Guicontrol,17:Enable,Bit_Right
		Guicontrol,17:Enable,Bit_Minus_Width
		Guicontrol,17:Enable,Bit_Plus_Width
		Guicontrol,17:Enable,Bit_Minus_Height
		Guicontrol,17:Enable,Bit_Plus_Height
		Guicontrol,17:Enable,Set_Bit_W
		Guicontrol,17:Enable,Set_Bit_H
		Guicontrol,17:Enable,Set_Bit_X
		Guicontrol,17:Enable,Set_Bit_Y
		Guicontrol,17:Enable,Zoom_Level
		Guicontrol,17:Enable,Bitmap_Smoothing
	}else	{
		Guicontrol,17:Disable,Bit_Up
		Guicontrol,17:Disable,Bit_Down
		Guicontrol,17:Disable,Bit_Left
		Guicontrol,17:Disable,Bit_Right
		Guicontrol,17:Disable,Bit_Minus_Width
		Guicontrol,17:Disable,Bit_Plus_Width
		Guicontrol,17:Disable,Bit_Minus_Height
		Guicontrol,17:Disable,Bit_Plus_Height
		Guicontrol,17:Disable,Set_Bit_W
		Guicontrol,17:Disable,Set_Bit_H
		Guicontrol,17:Disable,Set_Bit_X
		Guicontrol,17:Disable,Set_Bit_Y
		Guicontrol,17:Disable,Zoom_Level
		Guicontrol,17:Disable,Bitmap_Smoothing
	}
}

 Submit_Defaults(){
	Gui,9:Submit,NoHide
	For k, v in Default_Values
		Default_Values[k]:=%k%
	GuiControl,5:,New_Bitmap_X,% Default_Values.Default_Bitmap_X
	GuiControl,5:,New_Bitmap_Y,% Default_Values.Default_Bitmap_Y
	GuiControl,5:,New_Bitmap_W,% Default_Values.Default_Bitmap_W
	GuiControl,5:,New_Bitmap_H,% Default_Values.Default_Bitmap_H
	GuiControl,5:,New_Bitmap_Smoothing,% Default_Values.Default_Bitmap_Smoothing
}

Submit_17:
	Gui,17:Submit,NoHide
	Bitmap_Array[Active_Bitmap].X:=Set_Bit_X
	Bitmap_Array[Active_Bitmap].Y:=Set_Bit_Y
	Bitmap_Array[Active_Bitmap].W:=Set_Bit_W
	Bitmap_Array[Active_Bitmap].H:=Set_Bit_H
	Bitmap_Array[Active_Bitmap].Zoom:=Zoom_Level
	Bitmap_Array[Active_Bitmap].Smoothing:=Bitmap_Smoothing
	Bitmap_Array[Active_Bitmap].Zoom_Bitmap()
	GuiControl,4:Move,% Bitmap_Array[Active_Bitmap].Name,% "x" Bitmap_Array[Active_Bitmap].X " y" Bitmap_Array[Active_Bitmap].Y " w" Bitmap_Array[Active_Bitmap].W*Bitmap_Array[Active_Bitmap].Zoom " h" Bitmap_Array[Active_Bitmap].H*Bitmap_Array[Active_Bitmap].Zoom
	Move_Bitmap()
	if(Auto_Draw){
			SetTimer,Force_Draw,-10
		}	
	return

Dump_Name_In_Name_To_Save_Edit(){
	GuiControlGet,List_Of_Existing_Saves,7:,List_Of_Existing_Saves
	GuiControl,7:,Name_To_Save_Files,% List_Of_Existing_Saves 
}

Delete_Bitmap(){
	GuiControlGet,List_Of_Saved_Bitmaps,6:,List_Of_Saved_Bitmaps
	FileDelete,%List_Of_Saved_Bitmaps%.ini
	FileDelete,%A_ScriptDir%\HB Bitmap Maker Folder\Saved Bitmaps Functions\%List_Of_Saved_Bitmaps%.txt
	Load_Saved_Bitmap_List()
	SoundBeep,700
	TrayTip,,Done
	
}

Unlock_Delete_Bitmap(){
	Unlock_Delete_Button:=!Unlock_Delete_Button
	if(Unlock_Delete_Button)
		GuiControl,6:Enable,Delete_Bitmap_Button
	else
		GuiControl,6:Disable,Delete_Bitmap_Button
}

Move_Graphics(){
	CoordMode,Mouse,Client
	While(Getkeystate("LButton")){
		MouseGetPos,x,y
		y-=40
		GuiControl,4:Move,%A_GuiControl%,% "x" x " y" y
		Loop,% Bitmap_Array.Length()	{
			if(Bitmap_Array[A_Index].Name=A_GuiControl){
				Bitmap_Array[A_Index].X:=x
				Bitmap_Array[A_Index].Y:=y
				Loop,% Bitmap_Array.Length()
					Bitmap_Array[A_Index].move()
				break
			}
		}
	}
	Loop,% Bitmap_Array.Length()
			Bitmap_Array[A_Index].move()
	if(Bitmap_Array[Active_Bitmap].Name=A_GuiControl){		
		GuiControl,17:,Set_Bit_X,% Bitmap_Array[Active_Bitmap].X
		GuiControl,17:,Set_Bit_Y,% Bitmap_Array[Active_Bitmap].Y	
		GuiControl,17:,Set_Bit_W,% Bitmap_Array[Active_Bitmap].W	
		GuiControl,17:,Set_Bit_H,% Bitmap_Array[Active_Bitmap].H	
	}	
}

Unlock_Element_Remove(){
	static ElementLock
	ElementLock:=!ElementLock
	if(ElementLock){
		GuiControl,8:Enable,Element_Remove_Button
	}else	{
		GuiControl,8:Disable,Element_Remove_Button
	}
}

2GuiContextMenu(){
	static Tog2
	Tog2:=!Tog2
	if(!Tog2)
		Gui,2:Show,% "x0 y0 w300 h" Windows.H
	else
		Gui,2:Show,% "x-280 y0 w300 h" Windows.H
	Loop,% Bitmap_Array.Length()
		Bitmap_Array[A_Index].move()
}

3GuiContextMenu(){
	static Tog3
	Tog3:=!Tog3
	if(!Tog3)
		Gui,3:Show,% "x" Windows.W-300 " y0 w300 h" Windows.H
	else
		Gui,3:Show,% "x" Windows.W-20 " y0 w300 h" Windows.H
	Loop,% Bitmap_Array.Length()
		Bitmap_Array[A_Index].move()
}

11GuiContextMenu(){
	static Tog11
	Tog11:=!Tog11
	if(!Tog11)
		Gui,11:Show,x780 y500 w250 h200
	else
		Gui,11:Show,x780 y680 w250 h200
	Loop,% Bitmap_Array.Length()
		Bitmap_Array[A_Index].move()
}

16GuiContextMenu(){
	static Tog16
	Tog16:=!Tog16
	if(!Tog16)
		Gui,16:Show,x320 y500 w350 h200
	else
		Gui,16:Show,x320 y680 w350 h200
	Loop,% Bitmap_Array.Length()
		Bitmap_Array[A_Index].move()
}

Swap_Tabs(){
	if(A_GuiControl="Tab1"){
		Gui,5:Show ;,x10 y70 w300 h500
		Gui,6:Hide
		Gui,7:Hide
		GuiControl,2:+Background3399FF,Tab1_Background
		GuiControl,2:+Background777777,Tab2_Background
		GuiControl,2:+Background777777,Tab3_Background
	}else if(A_GuiControl="Tab2"){
		Gui,5:Hide
		Gui,6:Show ;,x10 y70 w300 h500
		Gui,7:Hide
		GuiControl,2:+Background777777,Tab1_Background
		GuiControl,2:+Background3399FF,Tab2_Background
		GuiControl,2:+Background777777,Tab3_Background
	}else if(A_GuiControl="Tab3"){
		Gui,5:Hide
		Gui,6:Hide
		Gui,7:Show ;,x10 y70 w300 h500
		GuiControl,2:+Background777777,Tab1_Background
		GuiControl,2:+Background777777,Tab2_Background
		GuiControl,2:+Background3399FF,Tab3_Background
	}else if(A_GuiControl="Tab4"){
		Gui,8:Show
		Gui,9:Hide
		Gui,10:Hide ;,x10 y70 w300 h500
		GuiControl,3:+Background3399FF,Tab4_Background
		GuiControl,3:+Background777777,Tab5_Background
		GuiControl,3:+Background777777,Tab6_Background
	}else if(A_GuiControl="Tab5"){
		Gui,8:Hide
		Gui,9:Show
		Gui,10:Hide ;,x10 y70 w300 h500
		GuiControl,3:+Background777777,Tab4_Background
		GuiControl,3:+Background3399FF,Tab5_Background
		GuiControl,3:+Background777777,Tab6_Background
	}else if(A_GuiControl="Tab6"){
		Gui,8:Hide
		Gui,9:Hide
		Gui,10:Show ;,x10 y70 w300 h500
		GuiControl,3:+Background777777,Tab4_Background
		GuiControl,3:+Background777777,Tab5_Background
		GuiControl,3:+Background3399FF,Tab6_Background
	}
	if(A_GuiControl="Tab1"||A_GuiControl="Tab2"||A_GuiControl="Tab3"){
		GuiControl,2:+Redraw,Tab1_Text
		GuiControl,2:+Redraw,Tab2_Text
		GuiControl,2:+Redraw,Tab3_Text
	}else	{
		GuiControl,3:+Redraw,Tab4_Text
		GuiControl,3:+Redraw,Tab5_Text
		GuiControl,3:+Redraw,Tab6_Text
	}
}

Change_Bitmap_Background_Color(){
	Gui,5:Submit,NoHide
	Gui,4:Color,% BitmapBackgroundColor
	sleep,20
	Loop,% Bitmap_Array.Length()
		Bitmap_Array[A_Index].move()
}

Add_Bitmaps_To_Bitmaps_List(){
	temp_Bitmap_List:=""
	Loop,% Bitmap_Array.Length(){
		temp_Bitmap_List.=Bitmap_Array[A_Index].Name "|"
	}
	GuiControl,1:,Active_Bitmaps_List,|
	GuiControl,1:,Active_Bitmaps_List,% temp_Bitmap_List
}

Hide_Element:
	Gui,13:Submit,NoHide
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Hidden:=Hide_Element
	Update_Element_List()
	GuiControl,8:Choose,Current_Elements,% Active_Element
	if(Auto_Draw){
			SetTimer,Force_Draw,-10
		}
	return

Force_Draw(){
	if(Bitmap_Array[Active_Bitmap]){
		Bitmap_Array[Active_Bitmap].Create_BitMap()
		loop, % Bitmap_Array[Active_Bitmap].Bitmap_Elements.Length(){
			if(Bitmap_Array[Active_Bitmap].Bitmap_Elements[A_Index].Hidden!=1)
				Bitmap_Array[Active_Bitmap][Bitmap_Array[Active_Bitmap].Bitmap_Elements[A_Index].Type](A_Index)
		}
		Bitmap_Array[Active_Bitmap].Move()
	}
}
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
; Refactored Code Credit - Speed Master

ReSize_Element:
keyShift:=GetKeyState("Shift")
(A_GuiControl=="Minus_Width" ) ? ( keyShift && (GetActiveElement("W")>10) ? ResizeElement(-10,0) : (GetActiveElement("W")>1) ? ResizeElement(-1, 0) )	
(A_GuiControl=="Plus_Width"  ) ? ( keyShift ? ResizeElement(10,0) : ResizeElement(1, 0) )	
(A_GuiControl=="Minus_Height") ? ( keyShift && (GetActiveElement("H")>10) ? ResizeElement(0,-10) : (GetActiveElement("H")>1) ? ResizeElement(0, -1) )	
(A_GuiControl=="Plus_Height" ) ? ( keyShift ? ResizeElement(0,10) : ResizeElement(0, 1) )
return

GetActiveElement(key) {
	return Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element][key]
}

ResizeElement(w:=0,h:=0) {
(w) ? Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element]["W"] +=w
(h) ? Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element]["H"] +=h
GuiControl,13:,W_Position,% Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element]["W"]
GuiControl,13:,H_Position,% Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element]["H"]
}

RePosition_Element() {
	keyShift:=GetKeyState("Shift")
	(A_GuiControl=="Move_Up") 		? 	( keyShift ?	MoveElement(-10,0) 		: MoveElement(-1, 0) )
	(A_GuiControl=="Move_Down") 	? 	( keyShift ?	MoveElement(10, 0) 		: MoveElement( 1, 0) ) 	
	(A_GuiControl=="Move_Left") 	? 	( keyShift ?	MoveElement(0,-10)		: MoveElement( 0,-1) )
	(A_GuiControl=="Move_Right") 	? 	( keyShift ?	MoveElement(0, 10) 		: MoveElement( 0, 1) )

	(A_GuiControl=="Move_Up2") 		? 	( keyShift ?	MoveElement(-10,0,2) 	: MoveElement(-1, 0,2) )
	(A_GuiControl=="Move_Down2") 	? 	( keyShift ?	MoveElement(10, 0,2) 	: MoveElement( 1, 0,2) )
	(A_GuiControl=="Move_Left2") 	? 	( keyShift ?	MoveElement(0,-10,2)	: MoveElement( 0,-1,2) )
	(A_GuiControl=="Move_Right2") 	? 	( keyShift ?	MoveElement(0, 10,2) 	: MoveElement( 0, 1,2) )

	(A_GuiControl=="Move_Up3") 		? 	( keyShift ?	MoveElement(-10,0,3) 	: MoveElement(-1, 0,3) )
	(A_GuiControl=="Move_Down3") 	? 	( keyShift ?	MoveElement(10, 0,3) 	: MoveElement( 1, 0,3) )
	(A_GuiControl=="Move_Left3") 	? 	( keyShift ?	MoveElement(0,-10,3)	: MoveElement( 0,-1,3) )
	(A_GuiControl=="Move_Right3") 	? 	( keyShift ?	MoveElement(0, 10,3) 	: MoveElement( 0, 1,3) )
	
	(A_GuiControl=="Move_Up4") 		? 	( keyShift ?	MoveElement(-10,0,4) 	: MoveElement(-1, 0,4) )
	(A_GuiControl=="Move_Down4") 	? 	( keyShift ?	MoveElement(10, 0,4) 	: MoveElement( 1, 0,4) )
	(A_GuiControl=="Move_Left4") 	? 	( keyShift ?	MoveElement(0,-10,4)	: MoveElement( 0,-1,4) )
	(A_GuiControl=="Move_Right4") 	? 	( keyShift ?	MoveElement(0, 10,4) 	: MoveElement( 0, 1,4) )	
}

MoveElement(y:=0,x:=0,Enum:="") {
Current_Element:=Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element]	
(y) ? Current_Element["Y" Enum] +=y
(x) ? Current_Element["X" Enum] +=x
GuiControl,13:,Y%Enum%_Position,% Current_Element["Y" Enum]
GuiControl,13:,X%Enum%_Position,% Current_Element["X" Enum]
	if(Auto_Draw)
		SetTimer,Force_Draw,-10
}

;----------------------------------------------------------------------------
;----------------------------------------------------------------------------
;----------------------------------------------------------------------------
;NEW HOTKEYS - Submitted By: Speed Master

#IfWinActive HB Bitmap Maker

up::MoveElement(-1,0), (GetActiveElement("type")="Draw_Line" || GetActiveElement("type")="Draw_Bezier") ? MoveElement(-1,0,2), MoveElement(-1,0,3), MoveElement(-1,0,4)
down::MoveElement(1,0), (GetActiveElement("type")="Draw_Line" || GetActiveElement("type")="Draw_Bezier") ? MoveElement(1,0,2), MoveElement(1,0,3), MoveElement(1,0,4)
left::MoveElement(0,-1), (GetActiveElement("type")="Draw_Line" || GetActiveElement("type")="Draw_Bezier") ? MoveElement(0,-1,2), MoveElement(0,-1,3), MoveElement(0,-1,4)
right::MoveElement(0,1), (GetActiveElement("type")="Draw_Line" || GetActiveElement("type")="Draw_Bezier") ? MoveElement(0,1,2), MoveElement(0,1,3), MoveElement(0,1,4)

+up::MoveElement(-10,0), (GetActiveElement("type")="Draw_Line" || GetActiveElement("type")="Draw_Bezier") ? MoveElement(-10,0,2), MoveElement(-10,0,3), MoveElement(-10,0,4)
+down::MoveElement(10,0), (GetActiveElement("type")="Draw_Line" || GetActiveElement("type")="Draw_Bezier") ? MoveElement(10,0,2), MoveElement(10,0,3), MoveElement(10,0,4)
+left::MoveElement(0,-10), (GetActiveElement("type")="Draw_Line" || GetActiveElement("type")="Draw_Bezier") ? MoveElement(0,-10,2), MoveElement(0,-10,3), MoveElement(0,-10,4)
+right::MoveElement(0,10), (GetActiveElement("type")="Draw_Line" || GetActiveElement("type")="Draw_Bezier") ? MoveElement(0,10,2), MoveElement(0,10,3), MoveElement(0,10,4)

^up::(GetActiveElement("type")="Draw_Line") ?  MoveElement(-1,0) : (GetActiveElement("H")>1) ? ResizeElement(0,-1)
^down::(GetActiveElement("type")="Draw_Line") ?  MoveElement(1,0) : ResizeElement(0,1)
^left::(GetActiveElement("type")="Draw_Line") ?  MoveElement(0,-1) : (GetActiveElement("w")>1) ? ResizeElement(-1,0)
^right::(GetActiveElement("type")="Draw_Line") ?  MoveElement(0,1) : ResizeElement(1,0)

^+up::(GetActiveElement("H")>10) ? ResizeElement(0,-10) : (GetActiveElement("H")>1) ? ResizeElement(0,-1)
^+down::ResizeElement(0,10)
^+left::(GetActiveElement("w")>10) ? ResizeElement(-10,0) : (GetActiveElement("W")>1) ? ResizeElement(-1,0)
^+right::ResizeElement(10,0)

#up::(GetActiveElement("type")="Draw_Line") ?  MoveElement(-1,0,2) 
#down::(GetActiveElement("type")="Draw_Line") ?  MoveElement(1,0,2) 
#left::(GetActiveElement("type")="Draw_Line") ?  MoveElement(0,-1,2) 
#right::(GetActiveElement("type")="Draw_Line") ?  MoveElement(0,1,2) 

^d::Clone_Element()

#If ; end

;End of - Speed Master Code Section
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------


Set_Color_1(){
	CoordMode,Mouse,Screen
	CoordMode,Pixel,Screen
	While(!GetKeyState("ctrl")){
		ToolTip, hover over color and press "ctrl" 
		
	}
	ToolTip,
	MouseGetPos,xt,yt
	PixelGetColor,Color,xt,yt,RGB
	CoordMode,Mouse,Client
	StringTrimLeft,Color,Color,2
	GuiControl,14:,Color,% Color
}
Set_Color_2(){
	CoordMode,Mouse,Screen
	CoordMode,Pixel,Screen
	While(!GetKeyState("ctrl")){
		ToolTip, hover over color and press "ctrl" 
	}
	ToolTip,
	MouseGetPos,xt,yt
	PixelGetColor,Color2,xt,yt,RGB
	CoordMode,Mouse,Client
	StringTrimLeft,Color2,Color2,2
	GuiControl,14:,Color2,% Color2
}
;Submit element values
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
Submit_13:
	Gui,13:Submit,NoHide
	Gui,14:Submit,NoHide
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].X:=X_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Y:=Y_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].W:=W_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].H:=H_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Notes:=Notes
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Alpha:=Alpha
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Color:=Color
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].X2:=X2_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Y2:=Y2_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].X3:=X3_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Y3:=Y3_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].X4:=X4_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Y4:=Y4_Position
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Radius:=Radius
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Thickness:=Thickness
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Text:=Text
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Options:=Options
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Font:=Font
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Start_Angle:=Start_Angle
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].End_Angle:=End_Angle
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Polygon_List:=Polygon_List
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Lines_List:=Lines_List
	
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Brush_Type:=Brush_Type
	if(Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Brush_Type=2){
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Hatch:=Hatch
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Alpha2:=Alpha2
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Color2:=Color2
	}
	if(Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Brush_Type=3){
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Line_Brush_X1:=Line_Brush_X1
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Line_Brush_Y1:=Line_Brush_Y1
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Line_Brush_X2:=Line_Brush_X2
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Line_Brush_Y2:=Line_Brush_Y2
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Line_Brush_Wrap_Mode:=Line_Brush_Wrap_Mode
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Alpha2:=Alpha2
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Color2:=Color2
	}
	if(Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Brush_Type=4){
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Grade_Brush_X:=Grade_Brush_X
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Grade_Brush_Y:=Grade_Brush_Y
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Grade_Brush_W:=Grade_Brush_W
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Grade_Brush_H:=Grade_Brush_H
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Grade_Brush_LinearGradientMode:=Grade_Brush_LinearGradientMode
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Grade_Brush_Wrap_Mode:=Grade_Brush_Wrap_Mode
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Alpha2:=Alpha2
		Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Color2:=Color2
	}
	if(Auto_Draw){
		SetTimer,Force_Draw,-10
	}
	return
Submit_Brush_Type:
	Gui,13:Submit,NoHide
	Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element].Brush_Type:=Brush_Type
	Constructor.Create_Brush_Window(Bitmap_Array[Active_Bitmap].Bitmap_Elements[Active_Element])
	if(Auto_Draw){
		SetTimer,Force_Draw,-10
	}
	return	

Layered_Window_SetUp(Smoothing,Window_X,Window_Y,Window_W,Window_H,Window_Name:=1,Window_Options:=""){
	Layered:={}
	Layered.W:=Window_W
	Layered.H:=Window_H
	Layered.X:=Window_X
	Layered.Y:=Window_Y
	Layered.Name:=Window_Name
	Layered.Options:=Window_Options
	Layered.Token:=Gdip_Startup()
	Create_Layered_GUI(Layered)
	Layered.hwnd:=winExist()
	Layered.hbm := CreateDIBSection(Window_W,Window_H)
	Layered.hdc := CreateCompatibleDC()
	Layered.obm := SelectObject(Layered.hdc,Layered.hbm)
	Layered.G := Gdip_GraphicsFromHDC(Layered.hdc)
	Gdip_SetSmoothingMode(Layered.G,Smoothing)
	return Layered
}
Create_Layered_GUI(Layered){
	Gui,% Layered.Name ": +E0x80000 +LastFound " Layered.Options 
	Gui,% Layered.Name ":Show",% "x" Layered.X " y" Layered.Y " w" Layered.W " h" Layered.H " NA"
}	
Layered_Window_ShutDown(This){
	SelectObject(This.hdc,This.obm)
	DeleteObject(This.hbm)
	DeleteDC(This.hdc)
	gdip_deleteGraphics(This.g)
	Gdip_Shutdown(This.Token)
}
Gdip_RotateBitmap(pBitmap, Angle, Dispose=1) { ; returns rotated bitmap. By Learning one.
Gdip_GetImageDimensions(pBitmap, Width, Height)
Gdip_GetRotatedDimensions(Width, Height, Angle, RWidth, RHeight)
Gdip_GetRotatedTranslation(Width, Height, Angle, xTranslation, yTranslation)
pBitmap2 := Gdip_CreateBitmap(RWidth, RHeight)
G2 := Gdip_GraphicsFromImage(pBitmap2), Gdip_SetSmoothingMode(G2, 4), Gdip_SetInterpolationMode(G2, 7)
Gdip_TranslateWorldTransform(G2, xTranslation, yTranslation)
Gdip_RotateWorldTransform(G2, Angle)
Gdip_DrawImage(G2, pBitmap, 0, 0, Width, Height)
Gdip_ResetWorldTransform(G2)
Gdip_DeleteGraphics(G2)
if Dispose
Gdip_DisposeImage(pBitmap)
return pBitmap2
}

New_Brush(colour:="000000",Alpha:="FF"){
	new_colour := "0x" Alpha colour 
	return Gdip_BrushCreateSolid(new_colour)
}
	
New_Pen(colour:="000000",Alpha:="FF",Width:= 5){
	new_colour := "0x" Alpha colour 
	return Gdip_CreatePen(New_Colour,Width)
}	
Fill_Box(pGraphics,pBrush,x,y,w,h)	{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillRectangle", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}
Draw_Box(pGraphics, pPen, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;                         GDIP LIB
;############################################################################################################################################
;############################################################################################################################################
;############################################################################################################################################
;############################################################################################################################################

;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; Supports: Basic, _L ANSi, _L Unicode x86 and _L Unicode x64
;
; Updated 2/20/2014 - fixed Gdip_CreateRegion() and Gdip_GetClipRegion() on AHK Unicode x86
; Updated 5/13/2013 - fixed Gdip_SetBitmapToClipboard() on AHK Unicode x64
;
;#####################################################################################
;#####################################################################################
UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if ((x != "") && (y != ""))
		VarSetCapacity(pt, 8), NumPut(x, pt, 0, "UInt"), NumPut(y, pt, 4, "UInt")
	if (w = "") ||(h = "")
		WinGetPos,,, w, h, ahk_id %hwnd%
	return DllCall("UpdateLayeredWindow", Ptr, hwnd, Ptr, 0, Ptr, ((x = "") && (y = "")) ? 0 : &pt, "int64*", w|h<<32, Ptr, hdc, "int64*", 0, "uint", 0, "UInt*", Alpha<<16|1<<24, "uint", 2)
}
BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster=""){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdi32\BitBlt", Ptr, dDC, "int", dx, "int", dy, "int", dw, "int", dh, Ptr, sDC, "int", sx, "int", sy, "uint", Raster ? Raster : 0x00CC0020)
}
StretchBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, sw, sh, Raster=""){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdi32\StretchBlt", Ptr, ddc, "int", dx, "int", dy, "int", dw, "int", dh, Ptr, sdc, "int", sx, "int", sy, "int", sw, "int", sh, "uint", Raster ? Raster : 0x00CC0020)
}
SetStretchBltMode(hdc, iStretchMode=4){
	return DllCall("gdi32\SetStretchBltMode", A_PtrSize ? "UPtr" : "UInt", hdc, "int", iStretchMode)
}
SetImage(hwnd, hBitmap){
	SendMessage, 0x172, 0x0, hBitmap,, ahk_id %hwnd%
	E := ErrorLevel
	DeleteObject(E)
	return E
}
SetSysColorToControl(hwnd, SysColor=15){
   WinGetPos,,, w, h, ahk_id %hwnd%
   bc := DllCall("GetSysColor", "Int", SysColor, "UInt")
   pBrushClear := Gdip_BrushCreateSolid(0xff000000 | (bc >> 16 | bc & 0xff00 | (bc & 0xff) << 16))
   pBitmap := Gdip_CreateBitmap(w, h), G := Gdip_GraphicsFromImage(pBitmap)
   Gdip_FillRectangle(G, pBrushClear, 0, 0, w, h)
   hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
   SetImage(hwnd, hBitmap)
   Gdip_DeleteBrush(pBrushClear)
   Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
   return 0
}
Gdip_BitmapFromScreen(Screen=0, Raster=""){
	if(Screen = 0){
		Sysget, x, 76
		Sysget, y, 77	
		Sysget, w, 78
		Sysget, h, 79
	}
	else if (SubStr(Screen, 1, 5) = "hwnd:")
	{
		Screen := SubStr(Screen, 6)
		if !WinExist( "ahk_id " Screen)
			return -2
		WinGetPos,,, w, h, ahk_id %Screen%
		x := y := 0
		hhdc := GetDCEx(Screen, 3)
	}
	else if (Screen&1 != "")
	{
		Sysget, M, Monitor, %Screen%
		x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop
	}
	else
	{
		StringSplit, S, Screen, |
		x := S1, y := S2, w := S3, h := S4
	}
	if (x = "") || (y = "") || (w = "") || (h = "")
		return -1
	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
	ReleaseDC(hhdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}
Gdip_BitmapFromHWND(hwnd){
	WinGetPos,,, Width, Height, ahk_id %hwnd%
	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
	PrintWindow(hwnd, hdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	return pBitmap
}
CreateRectF(ByRef RectF, x, y, w, h){
   VarSetCapacity(RectF, 16)
   NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
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
PrintWindow(hwnd, hdc, Flags=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("PrintWindow", Ptr, hwnd, Ptr, hdc, "uint", Flags)
}
DestroyIcon(hIcon){
	return DllCall("DestroyIcon", A_PtrSize ? "UPtr" : "UInt", hIcon)
}
PaintDesktop(hdc){
	return DllCall("PaintDesktop", A_PtrSize ? "UPtr" : "UInt", hdc)
}
CreateCompatibleBitmap(hdc, w, h){
	return DllCall("gdi32\CreateCompatibleBitmap", A_PtrSize ? "UPtr" : "UInt", hdc, "int", w, "int", h)
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
Gdip_LibraryVersion(){
	return 1.45
}
Gdip_LibrarySubVersion(){
	return 1.47
}
Gdip_BitmapFromBRA(ByRef BRAFromMemIn, File, Alternate=0){
	Static FName = "ObjRelease"
	if !BRAFromMemIn
		return -1
	Loop, Parse, BRAFromMemIn, `n
	{
		if (A_Index = 1)
		{
			StringSplit, Header, A_LoopField, |
			if (Header0 != 4 || Header2 != "BRA!")
				return -2
		}
		else if (A_Index = 2)
		{
			StringSplit, Info, A_LoopField, |
			if (Info0 != 3)
				return -3
		}
		else
			break
	}
	if !Alternate
		StringReplace, File, File, \, \\, All
	RegExMatch(BRAFromMemIn, "mi`n)^" (Alternate ? File "\|.+?\|(\d+)\|(\d+)" : "\d+\|" File "\|(\d+)\|(\d+)") "$", FileInfo)
	if !FileInfo
		return -4
	hData := DllCall("GlobalAlloc", "uint", 2, Ptr, FileInfo2, Ptr)
	pData := DllCall("GlobalLock", Ptr, hData, Ptr)
	DllCall("RtlMoveMemory", Ptr, pData, Ptr, &BRAFromMemIn+Info2+FileInfo1, Ptr, FileInfo2)
	DllCall("GlobalUnlock", Ptr, hData)
	DllCall("ole32\CreateStreamOnHGlobal", Ptr, hData, "int", 1, A_PtrSize ? "UPtr*" : "UInt*", pStream)
	DllCall("gdiplus\GdipCreateBitmapFromStream", Ptr, pStream, A_PtrSize ? "UPtr*" : "UInt*", pBitmap)
	If (A_PtrSize)
		%FName%(pStream)
	Else
		DllCall(NumGet(NumGet(1*pStream)+8), "uint", pStream)
	return pBitmap
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
Gdip_DrawBezier(pGraphics, pPen, x1, y1, x2, y2, x3, y3, x4, y4){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawBezier", Ptr, pgraphics, Ptr, pPen, "float", x1, "float", y1, "float", x2, "float", y2, "float", x3, "float", y3, "float", x4, "float", y4)
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
Gdip_FillPie(pGraphics, pBrush, x, y, w, h, StartAngle, SweepAngle){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillPie", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}
Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}
Gdip_FillRegion(pGraphics, pBrush, Region){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
}
Gdip_FillPath(pGraphics, pBrush, Path)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, Path)
}
Gdip_DrawImagePointsRect(pGraphics, pBitmap, Points, sx="", sy="", sw="", sh="", Matrix=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}

	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
		
	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		sx := 0, sy := 0
		sw := Gdip_GetImageWidth(pBitmap)
		sh := Gdip_GetImageHeight(pBitmap)
	}

	E := DllCall("gdiplus\GdipDrawImagePointsRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, Ptr, &PointF
				, "int", Points0
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}
Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		if (dx = "" && dy = "" && dw = "" && dh = "")
		{
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx := sy := 0
			sw := Gdip_GetImageWidth(pBitmap)
			sh := Gdip_GetImageHeight(pBitmap)
		}
	}

	E := DllCall("gdiplus\GdipDrawImageRectRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, "float", dx
				, "float", dy
				, "float", dw
				, "float", dh
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}
Gdip_SetImageAttributesColorMatrix(Matrix)
{
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

Gdip_GraphicsFromImage(pBitmap)
{
	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}
Gdip_GraphicsFromHDC(hdc)
{
    DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
    return pGraphics
}
Gdip_GetDC(pGraphics)
{
	DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
	return hdc
}
Gdip_ReleaseDC(pGraphics, hdc)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipReleaseDC", Ptr, pGraphics, Ptr, hdc)
}
Gdip_GraphicsClear(pGraphics, ARGB=0x00ffffff)
{
    return DllCall("gdiplus\GdipGraphicsClear", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", ARGB)
}
Gdip_BlurBitmap(pBitmap, Blur)
{
	if (Blur > 100) || (Blur < 1)
		return -1	
	sWidth := Gdip_GetImageWidth(pBitmap), sHeight := Gdip_GetImageHeight(pBitmap)
	dWidth := sWidth//Blur, dHeight := sHeight//Blur
	pBitmap1 := Gdip_CreateBitmap(dWidth, dHeight)
	G1 := Gdip_GraphicsFromImage(pBitmap1)
	Gdip_SetInterpolationMode(G1, 7)
	Gdip_DrawImage(G1, pBitmap, 0, 0, dWidth, dHeight, 0, 0, sWidth, sHeight)
	Gdip_DeleteGraphics(G1)
	pBitmap2 := Gdip_CreateBitmap(sWidth, sHeight)
	G2 := Gdip_GraphicsFromImage(pBitmap2)
	Gdip_SetInterpolationMode(G2, 7)
	Gdip_DrawImage(G2, pBitmap1, 0, 0, sWidth, sHeight, 0, 0, dWidth, dHeight)
	Gdip_DeleteGraphics(G2)
	Gdip_DisposeImage(pBitmap1)
	return pBitmap2
}
Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality=75)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	SplitPath, sOutput,,, Extension
	if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return -1
	Extension := "." Extension
	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2
	If (A_IsUnicode){
		StrGet_Name := "StrGet"
		Loop, %nCount%
		{
			sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
			if !InStr(sString, "*" Extension)
				continue
			
			pCodec := &ci+idx
			break
		}
	} else {
		Loop, %nCount%
		{
			Location := NumGet(ci, 76*(A_Index-1)+44)
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue
			pCodec := &ci+76*(A_Index-1)
			break
		}
	}
	
	if !pCodec
		return -3
	if (Quality != 75)
	{
		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if Extension in .JPG,.JPEG,.JPE,.JFIF
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
			Loop, % NumGet(EncoderParameters, "UInt")      ;%
			{
				elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
				if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
				{
					p := elem+&EncoderParameters-pad-4
					NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")
					break
				}
			}      
		}
	}
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wOutput, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, &wOutput, "int", nSize)
		VarSetCapacity(wOutput, -1)
		if !VarSetCapacity(wOutput)
			return -4
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &wOutput, Ptr, pCodec, "uint", p ? p : 0)
	}
	else
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &sOutput, Ptr, pCodec, "uint", p ? p : 0)
	return E ? -5 : 0
}
Gdip_GetPixel(pBitmap, x, y)
{
	DllCall("gdiplus\GdipBitmapGetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "uint*", ARGB)
	return ARGB
}
Gdip_SetPixel(pBitmap, x, y, ARGB)
{
   return DllCall("gdiplus\GdipBitmapSetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "int", ARGB)
}
Gdip_GetImageWidth(pBitmap){
   DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
   return Width
}
Gdip_GetImageHeight(pBitmap){
   DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
   return Height
}
Gdip_GetImageDimensions(pBitmap, ByRef Width, ByRef Height){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	DllCall("gdiplus\GdipGetImageWidth", Ptr, pBitmap, "uint*", Width)
	DllCall("gdiplus\GdipGetImageHeight", Ptr, pBitmap, "uint*", Height)
}
Gdip_GetDimensions(pBitmap, ByRef Width, ByRef Height){
	Gdip_GetImageDimensions(pBitmap, Width, Height)
}
Gdip_GetImagePixelFormat(pBitmap){
	DllCall("gdiplus\GdipGetImagePixelFormat", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", Format)
	return Format
}
Gdip_GetDpiX(pGraphics){
	DllCall("gdiplus\GdipGetDpiX", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpix)
	return Round(dpix)
}
Gdip_GetDpiY(pGraphics){
	DllCall("gdiplus\GdipGetDpiY", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpiy)
	return Round(dpiy)
}
Gdip_GetImageHorizontalResolution(pBitmap){
	DllCall("gdiplus\GdipGetImageHorizontalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpix)
	return Round(dpix)
}
Gdip_GetImageVerticalResolution(pBitmap){
	DllCall("gdiplus\GdipGetImageVerticalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpiy)
	return Round(dpiy)
}
Gdip_BitmapSetResolution(pBitmap, dpix, dpiy){
	return DllCall("gdiplus\GdipBitmapSetResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float", dpix, "float", dpiy)
}
Gdip_CreateBitmapFromFile(sFile, IconNumber=1, IconSize=""){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	SplitPath, sFile,,, ext
	if ext in exe,dll
	{
		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		BufSize := 16 + (2*(A_PtrSize ? A_PtrSize : 4))
		
		VarSetCapacity(buf, BufSize, 0)
		Loop, Parse, Sizes, |
		{
			DllCall("PrivateExtractIcons", "str", sFile, "int", IconNumber-1, "int", A_LoopField, "int", A_LoopField, PtrA, hIcon, PtrA, 0, "uint", 1, "uint", 0)
			if !hIcon
				continue
			if !DllCall("GetIconInfo", Ptr, hIcon, Ptr, &buf)
			{
				DestroyIcon(hIcon)
				continue
			}
			hbmMask  := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4))
			hbmColor := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4) + (A_PtrSize ? A_PtrSize : 4))
			if !(hbmColor && DllCall("GetObject", Ptr, hbmColor, "int", BufSize, Ptr, &buf))
			{
				DestroyIcon(hIcon)
				continue
			}
			break
		}
		if !hIcon
			return -1
		Width := NumGet(buf, 4, "int"), Height := NumGet(buf, 8, "int")
		hbm := CreateDIBSection(Width, -Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
		if !DllCall("DrawIconEx", Ptr, hdc, "int", 0, "int", 0, Ptr, hIcon, "uint", Width, "uint", Height, "uint", 0, Ptr, 0, "uint", 3)
		{
			DestroyIcon(hIcon)
			return -2
		}
		VarSetCapacity(dib, 104)
		DllCall("GetObject", Ptr, hbm, "int", A_PtrSize = 8 ? 104 : 84, Ptr, &dib) ; sizeof(DIBSECTION) = 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
		Stride := NumGet(dib, 12, "Int"), Bits := NumGet(dib, 20 + (A_PtrSize = 8 ? 4 : 0)) ; padding
		DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", Stride, "int", 0x26200A, Ptr, Bits, PtrA, pBitmapOld)
		pBitmap := Gdip_CreateBitmap(Width, Height)
		G := Gdip_GraphicsFromImage(pBitmap)
		, Gdip_DrawImage(G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
	}
	else
	{
		if (!A_IsUnicode)
		{
			VarSetCapacity(wFile, 1024)
			DllCall("kernel32\MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sFile, "int", -1, Ptr, &wFile, "int", 512)
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &wFile, PtrA, pBitmap)
		}
		else
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &sFile, PtrA, pBitmap)
	}
	
	return pBitmap
}
Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}
Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff){
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
	return hbm
}
Gdip_CreateBitmapFromHICON(hIcon){
	DllCall("gdiplus\GdipCreateBitmapFromHICON", A_PtrSize ? "UPtr" : "UInt", hIcon, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}
Gdip_CreateHICONFromBitmap(pBitmap){
	DllCall("gdiplus\GdipCreateHICONFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hIcon)
	return hIcon
}
Gdip_CreateBitmap(Width, Height, Format=0x26200A){
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
    Return pBitmap
}
Gdip_CreateBitmapFromClipboard(){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if !DllCall("OpenClipboard", Ptr, 0)
		return -1
	if !DllCall("IsClipboardFormatAvailable", "uint", 8)
		return -2
	if !hBitmap := DllCall("GetClipboardData", "uint", 2, Ptr)
		return -3
	if !pBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
		return -4
	if !DllCall("CloseClipboard")
		return -5
	DeleteObject(hBitmap)
	return pBitmap
}
Gdip_SetBitmapToClipboard(pBitmap){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	off1 := A_PtrSize = 8 ? 52 : 44, off2 := A_PtrSize = 8 ? 32 : 24
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	DllCall("GetObject", Ptr, hBitmap, "int", VarSetCapacity(oi, A_PtrSize = 8 ? 104 : 84, 0), Ptr, &oi)
	hdib := DllCall("GlobalAlloc", "uint", 2, Ptr, 40+NumGet(oi, off1, "UInt"), Ptr)
	pdib := DllCall("GlobalLock", Ptr, hdib, Ptr)
	DllCall("RtlMoveMemory", Ptr, pdib, Ptr, &oi+off2, Ptr, 40)
	DllCall("RtlMoveMemory", Ptr, pdib+40, Ptr, NumGet(oi, off2 - (A_PtrSize ? A_PtrSize : 4), Ptr), Ptr, NumGet(oi, off1, "UInt"))
	DllCall("GlobalUnlock", Ptr, hdib)
	DllCall("DeleteObject", Ptr, hBitmap)
	DllCall("OpenClipboard", Ptr, 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "uint", 8, Ptr, hdib)
	DllCall("CloseClipboard")
}
Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format=0x26200A){
	DllCall("gdiplus\GdipCloneBitmapArea", "float", x, "float", y, "float", w, "float", h, "int", Format, A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pBitmapDest)
	return pBitmapDest
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

;#####################################################################################

Gdip_CreateTextureBrush(pBitmap, WrapMode=1, x=0, y=0, w="", h="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	
	if !(w && h)
		DllCall("gdiplus\GdipCreateTexture", Ptr, pBitmap, "int", WrapMode, PtrA, pBrush)
	else
		DllCall("gdiplus\GdipCreateTexture2", Ptr, pBitmap, "int", WrapMode, "float", x, "float", y, "float", w, "float", h, PtrA, pBrush)
	return pBrush
}

Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
	DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}

Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1)
{
	CreateRectF(RectF, x, y, w, h)
	DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}

Gdip_CloneBrush(pBrush)
{
	DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
	return pBrushClone
}

Gdip_DeletePen(pPen)
{
   return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}

Gdip_DeleteBrush(pBrush)
{
   return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}

Gdip_DisposeImage(pBitmap)
{
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}

Gdip_DeleteGraphics(pGraphics)
{
   return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_DisposeImageAttributes(ImageAttr)
{
	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}

Gdip_DeleteFont(hFont)
{
   return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
}

Gdip_DeleteStringFormat(hFormat)
{
   return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
}

Gdip_DeleteFontFamily(hFamily)
{
   return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
}

Gdip_DeleteMatrix(Matrix)
{
   return DllCall("gdiplus\GdipDeleteMatrix", A_PtrSize ? "UPtr" : "UInt", Matrix)
}

Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0)
{
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

Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	
	return DllCall("gdiplus\GdipDrawString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, pBrush)
}

Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	VarSetCapacity(RC, 16)
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)   
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	
	DllCall("gdiplus\GdipMeasureString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, &RC
					, "uint*", Chars
					, "uint*", Lines)
	
	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}

; Near = 0
; Center = 1
; Far = 2
Gdip_SetStringFormatAlign(hFormat, Align)
{
   return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
}


Gdip_StringFormatCreate(Format=0, Lang=0)
{
   DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
   return hFormat
}

Gdip_FontCreate(hFamily, Size, Style=0)
{
   DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
   return hFont
}

Gdip_FontFamilyCreate(Font)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wFont, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
	}
	
	DllCall("gdiplus\GdipCreateFontFamilyFromName"
					, Ptr, A_IsUnicode ? &Font : &wFont
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "UInt*", hFamily)
	
	return hFamily
}

Gdip_CreateAffineMatrix(m11, m12, m21, m22, x, y)
{
   DllCall("gdiplus\GdipCreateMatrix2", "float", m11, "float", m12, "float", m21, "float", m22, "float", x, "float", y, A_PtrSize ? "UPtr*" : "UInt*", Matrix)
   return Matrix
}

Gdip_CreateMatrix()
{
   DllCall("gdiplus\GdipCreateMatrix", A_PtrSize ? "UPtr*" : "UInt*", Matrix)
   return Matrix
}
Gdip_CreatePath(BrushMode=0)
{
	DllCall("gdiplus\GdipCreatePath", "int", BrushMode, A_PtrSize ? "UPtr*" : "UInt*", Path)
	return Path
}

Gdip_AddPathEllipse(Path, x, y, w, h)
{
	return DllCall("gdiplus\GdipAddPathEllipse", A_PtrSize ? "UPtr" : "UInt", Path, "float", x, "float", y, "float", w, "float", h)
}

Gdip_AddPathPolygon(Path, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}   

	return DllCall("gdiplus\GdipAddPathPolygon", Ptr, Path, Ptr, &PointF, "int", Points0)
}

Gdip_DeletePath(Path)
{
	return DllCall("gdiplus\GdipDeletePath", A_PtrSize ? "UPtr" : "UInt", Path)
}

Gdip_SetTextRenderingHint(pGraphics, RenderingHint)
{
	return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
}

Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
{
   return DllCall("gdiplus\GdipSetInterpolationMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", InterpolationMode)
}
Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
{
   return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}
Gdip_SetCompositingMode(pGraphics, CompositingMode=0)
{
   return DllCall("gdiplus\GdipSetCompositingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", CompositingMode)
}

Gdip_Startup()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}

Gdip_Shutdown(pToken)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}

Gdip_RotateWorldTransform(pGraphics, Angle, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipRotateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", Angle, "int", MatrixOrder)
}

Gdip_ScaleWorldTransform(pGraphics, x, y, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipScaleWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_TranslateWorldTransform(pGraphics, x, y, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipTranslateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_ResetWorldTransform(pGraphics)
{
	return DllCall("gdiplus\GdipResetWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetRotatedTranslation(Width, Height, Angle, ByRef xTranslation, ByRef yTranslation)
{
	pi := 3.14159, TAngle := Angle*(pi/180)	

	Bound := (Angle >= 0) ? Mod(Angle, 360) : 360-Mod(-Angle, -360)
	if ((Bound >= 0) && (Bound <= 90))
		xTranslation := Height*Sin(TAngle), yTranslation := 0
	else if ((Bound > 90) && (Bound <= 180))
		xTranslation := (Height*Sin(TAngle))-(Width*Cos(TAngle)), yTranslation := -Height*Cos(TAngle)
	else if ((Bound > 180) && (Bound <= 270))
		xTranslation := -(Width*Cos(TAngle)), yTranslation := -(Height*Cos(TAngle))-(Width*Sin(TAngle))
	else if ((Bound > 270) && (Bound <= 360))
		xTranslation := 0, yTranslation := -Width*Sin(TAngle)
}

Gdip_GetRotatedDimensions(Width, Height, Angle, ByRef RWidth, ByRef RHeight)
{
	pi := 3.14159, TAngle := Angle*(pi/180)
	if !(Width && Height)
		return -1
	RWidth := Ceil(Abs(Width*Cos(TAngle))+Abs(Height*Sin(TAngle)))
	RHeight := Ceil(Abs(Width*Sin(TAngle))+Abs(Height*Cos(Tangle)))
}


Gdip_ImageRotateFlip(pBitmap, RotateFlipType=1)
{
	return DllCall("gdiplus\GdipImageRotateFlip", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", RotateFlipType)
}

Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0)
{
   return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}

Gdip_SetClipPath(pGraphics, Path, CombineMode=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, Path, "int", CombineMode)
}

Gdip_ResetClip(pGraphics)
{
   return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetClipRegion(pGraphics)
{
	Region := Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt*", Region)
	return Region
}

Gdip_SetClipRegion(pGraphics, Region, CombineMode=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
}

Gdip_CreateRegion()
{
	DllCall("gdiplus\GdipCreateRegion", "UInt*", Region)
	return Region
}

Gdip_DeleteRegion(Region)
{
	return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
}


Gdip_LockBits(pBitmap, x, y, w, h, ByRef Stride, ByRef Scan0, ByRef BitmapData, LockMode = 3, PixelFormat = 0x26200a)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	CreateRect(Rect, x, y, w, h)
	VarSetCapacity(BitmapData, 16+2*(A_PtrSize ? A_PtrSize : 4), 0)
	E := DllCall("Gdiplus\GdipBitmapLockBits", Ptr, pBitmap, Ptr, &Rect, "uint", LockMode, "int", PixelFormat, Ptr, &BitmapData)
	Stride := NumGet(BitmapData, 8, "Int")
	Scan0 := NumGet(BitmapData, 16, Ptr)
	return E
}

Gdip_UnlockBits(pBitmap, ByRef BitmapData)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("Gdiplus\GdipBitmapUnlockBits", Ptr, pBitmap, Ptr, &BitmapData)
}

Gdip_SetLockBitPixel(ARGB, Scan0, x, y, Stride)
{
	Numput(ARGB, Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_GetLockBitPixel(Scan0, x, y, Stride)
{
	return NumGet(Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_PixelateBitmap(pBitmap, ByRef pBitmapOut, BlockSize)
{
	static PixelateBitmap
	
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!PixelateBitmap)
	{
		if A_PtrSize != 8 ; x86 machine code
		MCode_PixelateBitmap =
		(LTrim Join
		558BEC83EC3C8B4514538B5D1C99F7FB56578BC88955EC894DD885C90F8E830200008B451099F7FB8365DC008365E000894DC88955F08945E833FF897DD4
		397DE80F8E160100008BCB0FAFCB894DCC33C08945F88945FC89451C8945143BD87E608B45088D50028BC82BCA8BF02BF2418945F48B45E02955F4894DC4
		8D0CB80FAFCB03CA895DD08BD1895DE40FB64416030145140FB60201451C8B45C40FB604100145FC8B45F40FB604020145F883C204FF4DE475D6034D18FF
		4DD075C98B4DCC8B451499F7F98945148B451C99F7F989451C8B45FC99F7F98945FC8B45F899F7F98945F885DB7E648B450C8D50028BC82BCA83C103894D
		C48BC82BCA41894DF48B4DD48945E48B45E02955E48D0C880FAFCB03CA895DD08BD18BF38A45148B7DC48804178A451C8B7DF488028A45FC8804178A45F8
		8B7DE488043A83C2044E75DA034D18FF4DD075CE8B4DCC8B7DD447897DD43B7DE80F8CF2FEFFFF837DF0000F842C01000033C08945F88945FC89451C8945
		148945E43BD87E65837DF0007E578B4DDC034DE48B75E80FAF4D180FAFF38B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945CC0F
		B6440E030145140FB60101451C0FB6440F010145FC8B45F40FB604010145F883C104FF4DCC75D8FF45E4395DE47C9B8B4DF00FAFCB85C9740B8B451499F7
		F9894514EB048365140033F63BCE740B8B451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB
		038975F88975E43BDE7E5A837DF0007E4C8B4DDC034DE48B75E80FAF4D180FAFF38B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955CC8A55
		1488540E038A551C88118A55FC88540F018A55F888140183C104FF4DCC75DFFF45E4395DE47CA68B45180145E0015DDCFF4DC80F8594FDFFFF8B451099F7
		FB8955F08945E885C00F8E450100008B45EC0FAFC38365DC008945D48B45E88945CC33C08945F88945FC89451C8945148945103945EC7E6085DB7E518B4D
		D88B45080FAFCB034D108D50020FAF4D18034DDC8BF08BF88945F403CA2BF22BFA2955F4895DC80FB6440E030145140FB60101451C0FB6440F010145FC8B
		45F40FB604080145F883C104FF4DC875D8FF45108B45103B45EC7CA08B4DD485C9740B8B451499F7F9894514EB048365140033F63BCE740B8B451C99F7F9
		89451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975103975EC7E5585DB7E468B4DD88B450C
		0FAFCB034D108D50020FAF4D18034DDC8BF08BF803CA2BF22BFA2BC2895DC88A551488540E038A551C88118A55FC88540F018A55F888140183C104FF4DC8
		75DFFF45108B45103B45EC7CAB8BC3C1E0020145DCFF4DCC0F85CEFEFFFF8B4DEC33C08945F88945FC89451C8945148945103BC87E6C3945F07E5C8B4DD8
		8B75E80FAFCB034D100FAFF30FAF4D188B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945C80FB6440E030145140FB60101451C0F
		B6440F010145FC8B45F40FB604010145F883C104FF4DC875D833C0FF45108B4DEC394D107C940FAF4DF03BC874068B451499F7F933F68945143BCE740B8B
		451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975083975EC7E63EB0233F639
		75F07E4F8B4DD88B75E80FAFCB034D080FAFF30FAF4D188B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955108A551488540E038A551C8811
		8A55FC88540F018A55F888140883C104FF4D1075DFFF45088B45083B45EC7C9F5F5E33C05BC9C21800
		)
		else ; x64 machine code
		MCode_PixelateBitmap =
		(LTrim Join
		4489442418488954241048894C24085355565741544155415641574883EC28418BC1448B8C24980000004C8BDA99488BD941F7F9448BD0448BFA8954240C
		448994248800000085C00F8E9D020000418BC04533E4458BF299448924244C8954241041F7F933C9898C24980000008BEA89542404448BE889442408EB05
		4C8B5C24784585ED0F8E1A010000458BF1418BFD48897C2418450FAFF14533D233F633ED4533E44533ED4585C97E5B4C63BC2490000000418D040A410FAF
		C148984C8D441802498BD9498BD04D8BD90FB642010FB64AFF4403E80FB60203E90FB64AFE4883C2044403E003F149FFCB75DE4D03C748FFCB75D0488B7C
		24188B8C24980000004C8B5C2478418BC59941F7FE448BE8418BC49941F7FE448BE08BC59941F7FE8BE88BC69941F7FE8BF04585C97E4048639C24900000
		004103CA4D8BC1410FAFC94863C94A8D541902488BCA498BC144886901448821408869FF408871FE4883C10448FFC875E84803D349FFC875DA8B8C249800
		0000488B5C24704C8B5C24784183C20448FFCF48897C24180F850AFFFFFF8B6C2404448B2424448B6C24084C8B74241085ED0F840A01000033FF33DB4533
		DB4533D24533C04585C97E53488B74247085ED7E42438D0C04418BC50FAF8C2490000000410FAFC18D04814863C8488D5431028BCD0FB642014403D00FB6
		024883C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC17CB28BCD410FAFC985C9740A418BC299F7F98BF0EB0233F685C9740B418BC3
		99F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585C97E4D4C8B74247885ED7E3841
		8D0C14418BC50FAF8C2490000000410FAFC18D04814863C84A8D4431028BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2413BD17CBD
		4C8B7424108B8C2498000000038C2490000000488B5C24704503E149FFCE44892424898C24980000004C897424100F859EFDFFFF448B7C240C448B842480
		000000418BC09941F7F98BE8448BEA89942498000000896C240C85C00F8E3B010000448BAC2488000000418BCF448BF5410FAFC9898C248000000033FF33
		ED33F64533DB4533D24533C04585FF7E524585C97E40418BC5410FAFC14103C00FAF84249000000003C74898488D541802498BD90FB642014403D00FB602
		4883C2044403D80FB642FB03F00FB642FA03E848FFCB75DE488B5C247041FFC0453BC77CAE85C9740B418BC299F7F9448BE0EB034533E485C9740A418BC3
		99F7F98BD8EB0233DB85C9740A8BC699F7F9448BD8EB034533DB85C9740A8BC599F7F9448BD0EB034533D24533C04585FF7E4E488B4C24784585C97E3541
		8BC5410FAFC14103C00FAF84249000000003C74898488D540802498BC144886201881A44885AFF448852FE4883C20448FFC875E941FFC0453BC77CBE8B8C
		2480000000488B5C2470418BC1C1E00203F849FFCE0F85ECFEFFFF448BAC24980000008B6C240C448BA4248800000033FF33DB4533DB4533D24533C04585
		FF7E5A488B7424704585ED7E48418BCC8BC5410FAFC94103C80FAF8C2490000000410FAFC18D04814863C8488D543102418BCD0FB642014403D00FB60248
		83C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC77CAB418BCF410FAFCD85C9740A418BC299F7F98BF0EB0233F685C9740B418BC399
		F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585FF7E4E4585ED7E42418BCC8BC541
		0FAFC903CA0FAF8C2490000000410FAFC18D04814863C8488B442478488D440102418BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2
		413BD77CB233C04883C428415F415E415D415C5F5E5D5BC3
		)
		
		VarSetCapacity(PixelateBitmap, StrLen(MCode_PixelateBitmap)//2)
		Loop % StrLen(MCode_PixelateBitmap)//2		;%
			NumPut("0x" SubStr(MCode_PixelateBitmap, (2*A_Index)-1, 2), PixelateBitmap, A_Index-1, "UChar")
		DllCall("VirtualProtect", Ptr, &PixelateBitmap, Ptr, VarSetCapacity(PixelateBitmap), "uint", 0x40, A_PtrSize ? "UPtr*" : "UInt*", 0)
	}

	Gdip_GetImageDimensions(pBitmap, Width, Height)
	
	if (Width != Gdip_GetImageWidth(pBitmapOut) || Height != Gdip_GetImageHeight(pBitmapOut))
		return -1
	if (BlockSize > Width || BlockSize > Height)
		return -2

	E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1)
	E2 := Gdip_LockBits(pBitmapOut, 0, 0, Width, Height, Stride2, Scan02, BitmapData2)
	if (E1 || E2)
		return -3

	E := DllCall(&PixelateBitmap, Ptr, Scan01, Ptr, Scan02, "int", Width, "int", Height, "int", Stride1, "int", BlockSize)
	
	Gdip_UnlockBits(pBitmap, BitmapData1), Gdip_UnlockBits(pBitmapOut, BitmapData2)
	return 0
}

;#####################################################################################

Gdip_ToARGB(A, R, G, B)
{
	return (A << 24) | (R << 16) | (G << 8) | B
}

;#####################################################################################

Gdip_FromARGB(ARGB, ByRef A, ByRef R, ByRef G, ByRef B)
{
	A := (0xff000000 & ARGB) >> 24
	R := (0x00ff0000 & ARGB) >> 16
	G := (0x0000ff00 & ARGB) >> 8
	B := 0x000000ff & ARGB
}

;#####################################################################################

Gdip_AFromARGB(ARGB)
{
	return (0xff000000 & ARGB) >> 24
}

;#####################################################################################

Gdip_RFromARGB(ARGB)
{
	return (0x00ff0000 & ARGB) >> 16
}

;#####################################################################################

Gdip_GFromARGB(ARGB)
{
	return (0x0000ff00 & ARGB) >> 8
}

;#####################################################################################

Gdip_BFromARGB(ARGB)
{
	return 0x000000ff & ARGB
}

;#####################################################################################

StrGetB(Address, Length=-1, Encoding=0)
{
	; Flexible parameter handling:
	if Length is not integer
	Encoding := Length,  Length := -1

	; Check for obvious errors.
	if (Address+0 < 1024)
		return

	; Ensure 'Encoding' contains a numeric identifier.
	if Encoding = UTF-16
		Encoding = 1200
	else if Encoding = UTF-8
		Encoding = 65001
	else if SubStr(Encoding,1,2)="CP"
		Encoding := SubStr(Encoding,3)

	if !Encoding ; "" or 0
	{
		; No conversion necessary, but we might not want the whole string.
		if (Length == -1)
			Length := DllCall("lstrlen", "uint", Address)
		VarSetCapacity(String, Length)
		DllCall("lstrcpyn", "str", String, "uint", Address, "int", Length + 1)
	}
	else if Encoding = 1200 ; UTF-16
	{
		char_count := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "uint", 0, "uint", 0, "uint", 0, "uint", 0)
		VarSetCapacity(String, char_count)
		DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "str", String, "int", char_count, "uint", 0, "uint", 0)
	}
	else if Encoding is integer
	{
		; Convert from target encoding to UTF-16 then to the active code page.
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", 0, "int", 0)
		VarSetCapacity(String, char_count * 2)
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", &String, "int", char_count * 2)
		String := StrGetB(&String, char_count, 1200)
	}
	
	return String
}