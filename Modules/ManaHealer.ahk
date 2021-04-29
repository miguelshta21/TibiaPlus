;MANA HEALER MODULE

ManaHealer:
If (TurnManaHealer = 0)
		{
			PassthroughTurnManaHealer =
		}
Else If (TurnManaHealer = 1)
	{
		MsgBox, MANA HEALER ON
		
		CoordMode, Pixel, Screen
		CoordMode, Mouse, Screen
		SendMode Input
		SetKeyDelay, -1, -1
		SetMouseDelay, -1
		SetDefaultMouseSpeed, 0
		SetWinDelay, -1
		SetControlDelay, -1

		SetTimer, ManaHealer, 200 ; READ EVERY 200MS


		If WinActive("ahk_class Qt5QWindowOwnDCIcon")  ;SEARCH FOR TIBIA
		{
			ImageSearch, FirstStageX, FirstStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\stats\HP%Vida1%Percent.png		;% LOW PRIORITY LIFE
			if (ErrorLevel = 1)
			{
			ImageSearch, SecondStageX, SecondStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\stats\HP%Vida2%Percent.png	    ;% MEDIUM PRIORITY LIFE
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
	
	}
return
}
return