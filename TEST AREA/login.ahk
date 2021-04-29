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