#SingleInstance, Force
#MaxThreadsPerHotKey 2
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0

SetWorkingDir %A_ScriptDir%

MainFolder = %A_ScriptDir%

back2 = %A_ScriptDir%\website.jpg

Menu, Tray, Icon, Images\Icons\Health_Potion.ico ; Change the tray icon
I_Icon = Images\Icons\Health_Potion.ico ; Change Icon


EnterTibiaPlus:

; READ SETTINGS

IniRead, LifeLowPriority, %A_ScriptDir%\settings.ini, Life, vLifeLowPriority
IniRead, LifeMediumPriority, %A_ScriptDir%\settings.ini, Life, vLifeMediumPriority
IniRead, LifeHighPriority, %A_ScriptDir%\settings.ini, Life, vLifeHighPriority

IniRead, SpellLowPriorityHK, %A_ScriptDir%\settings.ini, SpellsHK, vSpellLowPriorityHK
IniRead, SpellMediumPriorityHK, %A_ScriptDir%\settings.ini, SpellsHK, vSpellMediumPriorityHK
IniRead, SpellHighPriorityHK, %A_ScriptDir%\settings.ini, SpellsHK, vSpellHighPriorityHK

IniRead, PotionLowPriorityHK, %A_ScriptDir%\settings.ini, PotionsHK, vPotionLowPriorityHK
IniRead, PotionMediumPriorityHK, %A_ScriptDir%\settings.ini, PotionsHK, vPotionMediumPriorityHK
IniRead, PotionHighPriorityHK, %A_ScriptDir%\settings.ini, PotionsHK, vPotionHighPriorityHK

; GUI LAYOUT


Gui, Main:Color, 4b3e40
Gui, Main:Show, w700 h450,Tibia Plus [Alpha 0.1.2]
WinSet, Style, -0xC00000, A

;LifeGui =============================================================
	Gui, Main:Font, bold
	Gui, Main:Add, Tab, w685 -Background, LIFE|MANA|COMBO|CONDITIONS
	Gui, Main:Font
;
;LOW PRIORITY ================================
	Gui, Main:Add, Text, x10 y30, LOW PRIORITY                                          ;TEXTO EXIBIDO NA GUI
	Gui, Main:Add, Text, x10 y50, LIFE AMOUNT                                          ;TEXTO EXIBIDO NA GUI
	Gui, Main:Add, DropDownList, w40 vLifeLowPriority, 5|10||20|30|40|50|60|70|80|90|95

	Gui, Main:Add, Text, x10 y95, SPELL HK                                              ;TEXTO EXIBIDO NA GUI
	Gui, Main:Add, Hotkey, vSpellLowPriorityHK w50, %SpellLowPriorityHK%                                                ;HOTKEY HEALER LOW PRIORITY

	Gui, Main:Add, Text, x10 y135, POTION HK
	Gui, Main:Add, Hotkey, vPotionLowPriorityHK w50, %PotionLowPriorityHK%
;
;MEDIUM PRIORITY ================================

	Gui, Main:Add, Text, x+50 y30, MEDIUM PRIORITY                                      
	Gui, Main:Add, Text, x110 y50, LIFE AMOUNT                                          
	Gui, Main:Add, DropDownList, w40 vLifeMediumPriority, 5|10||20|30|40|50|60|70|80|90|95

	Gui, Main:Add, Text, x110 y95, SPELL HK
	Gui, Main:Add, Hotkey, vSpellMediumPriorityHK w50, %SpellMediumPriorityHK%

	Gui, Main:Add, Text, x110 y135, POTION HK
	Gui, Main:Add, Hotkey, vPotionMediumPriorityHK w50, %PotionMediumPriorityHK%
;
;HIGH PRIORITY ================================

	Gui, Main:Add, Text, x+60 y30, HIGH PRIORITY
	Gui, Main:Add, Text, x220 y50, LIFE AMOUNT
	Gui, Main:Add, DropDownList, w40 vLifeHighPriority, 5|10||20|30|40|50|60|70|80|90|95

	Gui, Main:Add, Text, x220 y95, SPELL HK
	Gui, Main:Add, Hotkey, vSpellHighPriorityHK w50, %SpellHighPriorityHK%

	Gui, Main:Add, Text, x220 y135, POTION HK
	Gui, Main:Add, Hotkey, vPotionHighPriorityHK w50, %PotionHighPriorityHK%
;
;MANA HEALER ================================
	Gui, Main:Tab, 2

	Gui, Main:Add, Text, x10 y30, MANA AMOUNT
;
;COMBO ATTACKER ================================
	Gui, Main:Tab, 3

	Gui, Main:Add, Text, x10 y30, COMBO HOTKEYS
;
;CONDITIONS ================================

	Gui, Main:Tab, 4

	Gui, Main:Add, Text, y+, Utamo Vita
	Gui, Main:Add, Text, y+, Exana Kor
	Gui, Main:Add, Text, y+, Exana Flam
	Gui, Main:Add, Text, y+, Exana Mort
	Gui, Main:Add, Text, y+, Exana Vis
	Gui, Main:Add, Text, y+, Exana Pox

	Gui, Main:Tab
;
;TURN MODULES ON OR OFF ================================

	Gui, Main:Add, Checkbox, x10 vTurnLifeHealer gSettingsChanged, LIFE
	Gui, Main:Add, Checkbox, x10 gManaHealer, MANA
	Gui, Main:Add, Checkbox, x10 gComboAttack, COMBO
	Gui, Main:Add, Checkbox, x10 gConditionsHealer, CONDITIONS
	Gui, Main:Add, Button, xr w100 h25 gSaveSettings, SAVE SETTINGS
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
	Gui, Main:Submit, NoHide
return



SaveSettings:
Gui, Main:Submit, NoHide

IniWrite, %LifeLowPriority%, %A_ScriptDir%\settings.ini, Life, vLifeLowPriority
IniWrite, %LifeMediumPriority%, %A_ScriptDir%\settings.ini, Life, vLifeMediumPriority
IniWrite, %LifeHighPriority%, %A_ScriptDir%\settings.ini, Life, vLifeHighPriority

IniWrite, %SpellLowPriorityHK%, %A_ScriptDir%\settings.ini, SpellsHK, vSpellLowPriorityHK
IniWrite, %SpellMediumPriorityHK%, %A_ScriptDir%\settings.ini, SpellsHK, vSpellMediumPriorityHK
IniWrite, %SpellHighPriorityHK%, %A_ScriptDir%\settings.ini, SpellsHK, vSpellHighPriorityHK

IniWrite, %PotionLowPriorityHK%, %A_ScriptDir%\settings.ini, PotionsHK, vPotionLowPriorityHK
IniWrite, %PotionMediumPriorityHK%, %A_ScriptDir%\settings.ini, PotionsHK, vPotionMediumPriorityHK
IniWrite, %PotionHighPriorityHK%, %A_ScriptDir%\settings.ini, PotionsHK, vPotionHighPriorityHK

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
