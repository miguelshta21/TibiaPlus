#SingleInstance, Force
#MaxThreadsPerHotKey 2
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0


SetWorkingDir %A_ScriptDir%

Menu, Tray, Icon, Images\Icons\Health_Potion.ico ; Change the tray icon
I_Icon = Images\Icons\Health_Potion.ico ; Change Icon



InputBox, uNameTibiaPlus, LOGIN, Enter your username!
if uNameTibiaPlus = admin
	InputBox, uPassTibiaPlus, PASSWORD, Enter your password!, HIDE
Else
	{
		MsgBox, 48, Incorrect Username, Username not found
		Goto, LoginClose
	}

If uPassTibiaPlus = pass
	Goto, enterTibiaPlus

Else
	Msgbox, 48, Wrong Password, Password incorrect

LoginClose:
	ExitApp

Return

EnterTibiaPlus:

Msgbox, Login Sucessful!






; Gui Layout
;---------------------
;--------------------------

IniRead, lifesettings, %A_ScriptDir%\settings.ini, life, vLifeLowPriority vLifeMediumPriority vLifeHighPriority
IniRead, spellsettings, %A_ScriptDir%\settings.ini, spellshk, vSpellLowPriorityHK vSpellMediumPriorityHK vSpellHighPriorityHK
IniRead, potionsettings, %A_ScriptDir%\settings.ini, potionshk, vPotionLowPriorityHK vPotionMediumLowPriorityHK vPotionHighPriorityHK
IniRead, manapotionsettings, %A_ScriptDir%\settings.ini, manapotionhk, vManaPotionHK




Gui, Color, ad7b6b
Gui, Show, w350 h325,Tibia Plus [Alpha 0.1.1]







;LifeGui =============================================================
;=====================================================================

Gui, Font, bold
Gui, Add, Tab2, buttons, LIFE|MANA|COMBO|CONDITIONS
Gui, Font


;LOW PRIORITY =========================
;==============================

Gui, Add, Text, x10 y30, LOW PRIORITY                                          ;TEXTO EXIBIDO NA GUI
 Gui, Add, Text, x10 y50, LIFE AMOUNT                                          ;TEXTO EXIBIDO NA GUI
  Gui, Add, DropDownList, w40 vLifeLowPriority, 5|10||20|30|40|50|60|70|80|90|95         ;LISTA COM AS % DE HEAL

Gui, Add, Text, x10 y95, SPELL HK                                              ;TEXTO EXIBIDO NA GUI
 Gui, Add, Hotkey, vSpellLowPriorityHK w50                                                ;HOTKEY HEALER LOW PRIORITY

Gui, Add, Text, x10 y135, POTION HK
 Gui, Add, Hotkey, vPotionLowPriorityHK w50

;MEDIUM PRIORITY ========================
;===============================

Gui, Add, Text, x+50 y30, MEDIUM PRIORITY                                      
 Gui, Add, Text, x110 y50, LIFE AMOUNT                                          
  Gui, Add, DropDownList, w40 vLifeMediumPriority, 5|10||20|30|40|50|60|70|80|90|95

Gui, Add, Text, x110 y95, SPELL HK
 Gui, Add, Hotkey, vSpellMediumPriorityHK w50

Gui, Add, Text, x110 y135, POTION HK
 Gui, Add, Hotkey, vPotionMediumPriorityHK w50

;HIGH PRIORITY ===========================
;===============================

Gui, Add, Text, x+60 y30, HIGH PRIORITY
 Gui, Add, Text, x220 y50, LIFE AMOUNT
  Gui, Add, DropDownList, w40 vLifeHighPriority, 5|10||20|30|40|50|60|70|80|90|95

Gui, Add, Text, x220 y95, SPELL HK
 Gui, Add, Hotkey, vSpellHighPriorityHK w50

Gui, Add, Text, x220 y135, POTION HK
 Gui, Add, Hotkey, vPotionHighPriorityHK w50


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


Gui, Add, Checkbox, x10 gLifeHealer, LIFE
Gui, Add, Checkbox, x10 gManaHealer, MANA
Gui, Add, Checkbox, x10 gComboAttackHelp, COMBO
Gui, Add, Checkbox, x10 gConditionsHealer, CONDITIONS

Gui, Add, Text, x+20 y280, Healer Delay
	Gui, Add, Edit, vHealDelay y+

Gui, Add, Button, x10 y200 w100 h25 gSaveSettings, UPDATE SETTINGS

; Lables
;----------------
;----------------------


; LIFE HEALER HERE ==================================
;  ==================================================
{
	LifeHealer:

	CoordMode, Pixel, Screen
	CoordMode, Mouse, Screen
	SendMode Input
	SetKeyDelay, -1, -1
	SetMouseDelay, -1
	SetDefaultMouseSpeed, 0
	SetWinDelay, -1
	SetControlDelay, -1

	SetTimer, LifeHealer, 200 ;Read every 200 ms


	If WinActive("ahk_class Qt5QWindowOwnDCIcon")  ;Find out if Tibia is running and opened
	{
		ImageSearch, FirstStageX, FirstStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\stats\HP%Vida1%Percent.png		;% LOW PRIORITY LIFE
		if (ErrorLevel = 1)
		{
		ImageSearch, SecondStageX, SecondStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\stats\HP%Vida2%Percent.png	    ;% MEDIUM PRIORITY LIFE
		if (ErrorLevel = 1)
		{
		ImageSearch, ThirdStageX, ThirdStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\stats\HP%Vida3%Percent.png		;% HIGH PRIORITY LIFE
		if (ErrorLevel = 1)
		{
			Send, %SpellHighPriorityHK% ;SPELL HOTKEY HIGH PRIORITY
			Sleep 50
			Send, %PotionHighPriorityHK%	;POTION HOTKEY HIGH PRIORITY
			Sleep 200
			goto LifeHealer
		}
			Send, %SpellMediumPriorityHK% ;SPELL HOTKEY MEDIUM PRIORITY
			Sleep 50
			Send, %PotionMediumPriorityHK%	;POTION HOTKEY MEDIUM PRIORITY
			Sleep 200
			goto LifeHealer
		}
			Send, %SpellLowPriorityHK% ;SPELL HOTKEY LOW PRIORITY
			Sleep 50
			Send, %PotionLowPriorityHK%	;POTION HOTKEY LOW PRIORITY
			Sleep 200
			goto LifeHealer
		}
	}



	return

}
;MANA HEALER===============
;===========================


{
	ManaHealer:

	SetTimer, AutoHealingMana, 200 ;ler a cada 0,2 segundos

	ManaHealerChanged:	; Run when the CheckBox changes
	return



}


;CONDITIONS HEALER =================
;==================================


{
	ConditionsHealer:

	SetTimer, AutoHealingConditions, 200 ;ler a cada 0,2 segundos

	ConditionsHealerChanged:	; Run when the CheckBox changes
	return
}


{
	ComboAttack:

	ComboAttackHelpChanged:	; Run when the CheckBox changes
	return

}



;CONFIGS END HERE =========================
;==========================================


Return

SaveSettings:
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
	MsgBox, 4 , SETTINGS LOADED, SETTINGS LOADED! ARE YOU SURE?, 5
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