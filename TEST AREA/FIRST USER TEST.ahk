#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


f2::
checkcount = 0
loop{
checkcount++
IniRead, usercheck, C:\Users\mateu\Documents\GitHub\TibiaPlus\settings.ini, approvedusers, user%checkcount%
If usercheck = 
		{
			MsgBox, USER NOT APPROVED
			Return
		}
If a_username contains %usercheck%
	{
		break
	}
}
	