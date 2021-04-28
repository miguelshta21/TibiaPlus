#SingleInstance, Force
#MaxThreadsPerHotKey 2
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0

SetWorkingDir %A_ScriptDir%

Menu, Tray, Icon, Images\Icons\Health_Potion.ico ; Change the tray icon
I_Icon = Images\Icons\Health_Potion.ico ; Change Icon

;LOGIN ===========================
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



; GUI LAYOUT


Gui, Color, ad7b6b
Gui, Show, w350 h325,Tibia Plus [Alpha 0.1.1]


;LifeGui =============================================================
	Gui, Font, bold
	Gui, Add, Tab2, buttons, LIFE|MANA|COMBO|CONDITIONS
	Gui, Font
;
;LOW PRIORITY ================================
	Gui, Add, Text, x10 y30, LOW PRIORITY                                          ;TEXTO EXIBIDO NA GUI
	Gui, Add, Text, x10 y50, LIFE AMOUNT                                          ;TEXTO EXIBIDO NA GUI
	Gui, Add, DropDownList, w40 vLifeLowPriority, 5|10||20|30|40|50|60|70|80|90|95         ;LISTA COM AS % DE HEAL

	Gui, Add, Text, x10 y95, SPELL HK                                              ;TEXTO EXIBIDO NA GUI
	Gui, Add, Hotkey, vSpellLowPriorityHK w50                                                ;HOTKEY HEALER LOW PRIORITY

	Gui, Add, Text, x10 y135, POTION HK
	Gui, Add, Hotkey, vPotionLowPriorityHK w50
;
;MEDIUM PRIORITY ================================

	Gui, Add, Text, x+50 y30, MEDIUM PRIORITY                                      
	Gui, Add, Text, x110 y50, LIFE AMOUNT                                          
	Gui, Add, DropDownList, w40 vLifeMediumPriority, 5|10||20|30|40|50|60|70|80|90|95

	Gui, Add, Text, x110 y95, SPELL HK
	Gui, Add, Hotkey, vSpellMediumPriorityHK w50

	Gui, Add, Text, x110 y135, POTION HK
	Gui, Add, Hotkey, vPotionMediumPriorityHK w50
;
;HIGH PRIORITY ================================

	Gui, Add, Text, x+60 y30, HIGH PRIORITY
	Gui, Add, Text, x220 y50, LIFE AMOUNT
	Gui, Add, DropDownList, w40 vLifeHighPriority, 5|10||20|30|40|50|60|70|80|90|95

	Gui, Add, Text, x220 y95, SPELL HK
	Gui, Add, Hotkey, vSpellHighPriorityHK w50

	Gui, Add, Text, x220 y135, POTION HK
	Gui, Add, Hotkey, vPotionHighPriorityHK w50
;
;MANA HEALER ================================
	Gui, Tab, 2

	Gui, Add, Text, x10 y30, MANA AMOUNT
;
;COMBO ATTACKER ================================
	Gui, Tab, 3

	Gui, Add, Text, x10 y30, COMBO HOTKEYS
;
;CONDITIONS ================================

	Gui, Tab, 4

	Gui, Add, Text, y+, Utamo Vita
	Gui, Add, Text, y+, Exana Kor
	Gui, Add, Text, y+, Exana Flam
	Gui, Add, Text, y+, Exana Mort
	Gui, Add, Text, y+, Exana Vis
	Gui, Add, Text, y+, Exana Pox

	Gui, Tab
;
;TURN MODULES ON OR OFF ================================

	Gui, Add, Checkbox, x10 vTurnLifeHealer gSettingsChanged, LIFE
	Gui, Add, Checkbox, x10 gManaHealer, MANA
	Gui, Add, Checkbox, x10 gComboAttack, COMBO
	Gui, Add, Checkbox, x10 gConditionsHealer, CONDITIONS

	Gui, Add, Button, x10 y200 w100 h25 gSaveSettings, SAVE SETTINGS
	Gui, Submit, nohide 
;
;LIFE HEALER MODULE HERE ================================
 Loop{
	If (TurnLifeHealer = 0)
		{
			PassthroughTurnLifeHealer =
		}
	Else If (TurnLifeHealer = 1)
	{
	 #Include %A_ScriptDir%\Modules\LifeHealer.ahk
	}
	}
;
;MANA HEALER MODULE HERE ================================
	ManaHealer:

	SetTimer, ManaHealer, 200

	ManaHealerChanged:	; Run when the CheckBox changes
	return
;
;CONDITIONS MODULE HERE ================================
	ConditionsHealer:

	SetTimer, ConditionsHealer, 200

	ConditionsHealerChanged:	; Run when the CheckBox changes
	return

;
;COMBO ATTACK MODULE HERE ================================
	ComboAttack:

	SetTimer, ComboAttack, 200
	ComboAttackHelpChanged:	; Run when the CheckBox changes
	return
;


;CONFIGS END HERE =========================
;==========================================


SettingsChanged:

	CoordMode, Pixel, Screen
	CoordMode, Mouse, Screen
	SendMode Input
	SetKeyDelay, -1, -1
	SetMouseDelay, -1
	SetDefaultMouseSpeed, 0
	SetWinDelay, -1
	SetControlDelay, -1
	Gui, Submit, NoHide
return

SaveSettings:
Gui, Submit, NoHide
IniWrite, %LifeLowPriority%, %A_ScriptDir%\settings.ini, teste, numero
MsgBox, SETTINGS SAVED
return

GuiClose:
 MsgBox, 4 , Close Tibia Plus, Are you sure?, 60
  ifMsgBox TimeOut
    ExitApp
  Else ifMsgBox Yes
    ExitApp
  ifMsgBox No



del::ExitApp