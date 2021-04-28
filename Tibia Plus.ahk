#SingleInstance, Force
#MaxThreadsPerHotKey 2
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0


SetWorkingDir %A_ScriptDir%

; Gui Layout
;---------------------
;--------------------------

Gui, Color, ad7b6b

 Gui, Show, w350 h325,Tibia Plus
  Menu, Tray, Icon, Images\Health_Potion.ico ; Change the tray icon
   I_Icon = Images\Health_Potion.ico ; Change Icon

;LifeGui =============================================================
;=====================================================================

Gui, Font, bold
 Gui, Add, Tab2, buttons, LIFE|MANA|COMBO|CONDITIONS
  Gui, Font


;HIGH =========================
;==============================

Gui, Add, Text, x10 y30, LOW PRIORITY
 Gui, Add, Text, x10 y50, LIFE AMOUNT
  Gui, Add, DropDownList, w40 vVida1, %Vida1%5|10||20|30|40|50|60|70|80|90|95

Gui, Add, Text, x10 y95, SPELL HK
 Gui, Add, Hotkey, vHEALHK1 w50

Gui, Add, Text, x10 y135, POTION HK
 Gui, Add, Hotkey, vHPHK1 w50

;MEDIUM ========================
;===============================

Gui, Add, Text, x+50 y30, MEDIUM PRIORITY
 Gui, Add, Text, x110 y50, LIFE AMOUNT
  Gui, Add, DropDownList, w40 vVida2, %Vida2%5|10||20|30|40|50|60|70|80|90|95

Gui, Add, Text, x110 y95, SPELL HK
 Gui, Add, Hotkey, vHEALHK2 w50

Gui, Add, Text, x110 y135, POTION HK
 Gui, Add, Hotkey, vHPHK2 w50

;LOW ===========================
;===============================

Gui, Add, Text, x+60 y30, HIGH PRIORITY
 Gui, Add, Text, x220 y50, LIFE AMOUNT
  Gui, Add, DropDownList, w40 vVida3, %Vida3%5|10||20|30|40|50|60|70|80|90|95

Gui, Add, Text, x220 y95, SPELL HK
 Gui, Add, Hotkey, vHEALHK3 w50

Gui, Add, Text, x220 y135, POTION HK
 Gui, Add, Hotkey, vHPHK3 w50


Gui, Tab, 2

Gui, Add, Text, x10 y30, MANA AMOUNT

Gui, Tab, 3

Gui, Add, Text, x10 y30, COMBO HOTKEYS

Gui, Tab, 4

Gui, Add, Text, y+, Utamo Vita
  Gui, Add, Text, y+, Exana Kor
   Gui, Add, Text, y+, Exana Flam
    Gui, Add, Text, y+, Exana Mort
     Gui, Add, Text, y+, Exana Vis
      Gui, Add, Text, y+, Exana Pox

Gui, Tab


Gui, Add, Checkbox, x10 vLifeHealer gAutoHealingLife, LIFE
 Gui, Add, Checkbox, x10 vManaHealer gManaHealerChanged, MANA
  Gui, Add, Checkbox, x10 vComboAttackHelp gComboAttackHelpChanged, COMBO
   Gui, Add, Checkbox, x10 vConditionsHealer gConditionsHealerChanged, CONDITIONS

    Gui, Add, Text, x+20 y280, Healer Delay
     Gui, Add, Edit, vHealDelay y+

Gui, Add, Button, x10 y200 w100 h25 gSaveCFG, UPDATE CONFIGS

; Lables
;----------------
;----------------------


if (LifeHealer = 1) ; Enable or disable hotkey based on contents of CheckBoxDate variable
{
	AutoHealingLife:

	CoordMode, Pixel, Screen
	CoordMode, Mouse, Screen
	SendMode Input
	SetKeyDelay, -1, -1
	SetMouseDelay, -1
	SetDefaultMouseSpeed, 0
	SetWinDelay, -1
	SetControlDelay, -1

	SetTimer, AutoHealingLife, 200 ;Read every 200 ms


	If WinActive("ahk_class Qt5QWindowOwnDCIcon")  ;Find out if Tibia is running and opened
	{
		ImageSearch, FirstStageX, FirstStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\HP%Vida1%Percent.png		;% LOW PRIORITY LIFE
		if (ErrorLevel = 1)
		{
		ImageSearch, SecondStageX, SecondStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\HP%Vida2%Percent.png	    ;% MEDIUM PRIORITY LIFE
		if (ErrorLevel = 1)
		{
		ImageSearch, ThirdStageX, ThirdStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\HP%Vida3%Percent.png		;% HIGH PRIORITY LIFE
		if (ErrorLevel = 1)
		{
			Send, %HEALHK3% ;HOTKEY LOW PRIORITY
			Sleep 50
			Send, %HPHK3%	;HOTKEY LOW PRIORITY
			Sleep %HealDelay%
			goto AutoHealingLife
		}
			Send, %HEALHK2% ;HOTKEY MEDIUM PRIORITY
			Sleep 50
			Send, %HPHK2%	;HOTKEY MEDIUM PRIORITY
			Sleep %HealDelay%
			goto AutoHealingLife
		}
			Send, %HEALHK1% ;HOTKEY HIGH PRIORITY
			Sleep 50
			Send, %HPHK1%	;HOTKEY HIGH PRIORITY
			Sleep %HealDelay%
			goto AutoHealingLife
		}
	}



	return

}
;MANA HEALER===============
;===========================

if (ManaHealer=1)
{
	AutoHealingMana:

	SetTimer, AutoHealingMana, 200 ;ler a cada 0,2 segundos

	ManaHealerChanged:	; Run when the CheckBox changes
	return



}


;CONDITIONS HEALER =================
;==================================

if (ConditionsHealer=1)
{
	AutoHealingConditions:

	SetTimer, AutoHealingConditions, 200 ;ler a cada 0,2 segundos

	ConditionsHealerChanged:	; Run when the CheckBox changes
	return
}

if (ComboAttack=1)
{
	ComboAttackHelp:

	ComboAttackHelpChanged:	; Run when the CheckBox changes
	return

}



;CONFIGS END HERE =========================
;==========================================


Return

SaveCFG:
{ 
	CoordMode, Pixel, Screen
	CoordMode, Mouse, Screen
	SendMode Input
	SetKeyDelay, -1, -1
	SetMouseDelay, -1
	SetDefaultMouseSpeed, 0
	SetWinDelay, -1
	SetControlDelay, -1

	Gui, Submit, NoHide
	MsgBox, 4 , CONFIG LOADED, CONFIG LOADED! ARE YOU SURE?, 5
	 IfMsgBox TimeOut 
		MsgBox Ohhhhhhhhhhho
	 Else ifMsgBox Yes
	  MsgBox yesss
	 Else ifMsgBox No
	  MsgBox nooo
}

Return


; Functions
; ------------
; ------------------



GuiClose:
 MsgBox, 4 , Close Tibia Plus, Are you sure?, 60
  ifMsgBox TimeOut
    ExitApp
  Else ifMsgBox Yes
    ExitApp
  ifMsgBox No



del::ExitApp