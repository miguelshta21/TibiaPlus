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
			ImageSearch, FirstStageX, FirstStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\stats\MP%ManaLowPriority%Percent.png		;% LOW PRIORITY MANA
			if (ErrorLevel = 1)
			{
			ImageSearch, SecondStageX, SecondStageY, A_ScreenWidth - 368, 0, A_ScreenWidth, A_ScreenHeight + 470, *15, Images\stats\MP%ManaHighPriority%Percent.png	    ;% MEDIUM PRIORITY MANA
			if (ErrorLevel = 1)
			{
				Send, %ManaPotionHighPriorityHK%	;MANA POTION HOTKEY HIGH PRIORITY
				Sleep 200
				goto ManaHealer
			}
				Send, %ManaPotionMediumPriorityHK%	;MANA POTION HOTKEY LOW PRIORITY
				Sleep 200
				goto ManaHealer
			}
	
	}
return
}
return