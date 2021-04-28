;LIFE HEALER MODULE

LifeHealer:
If (TurnLifeHealer = 0)
		{
			PassthroughTurnLifeHealer =
		}
Else If (TurnLifeHealer = 1)
	{
		MsgBox, HEALER On
		
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
return