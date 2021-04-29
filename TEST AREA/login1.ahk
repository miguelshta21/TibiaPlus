#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


username = jl12345
password = 12345

InputBox, user, Please Enter User Name
InputBox,pass, Please Enter Password
[color=red]If ( user <> username ) OR ( pass <> password )[/color]
  ExitApp
MsgBox You reached here - correct!
Return

;===========================================================================
;============================================================================


User := "38A7C744B121F43A3347F9A9D235926C" ; this is the hashed version of "jl12345"
Pass := "827CCB0EEA8A706C4C34A16891F84E7B" ; this is the hashed version of "12345"

InputBox, CapUser, Please Enter User Name
InputBox, CapPass, Please Enter Password
If ( MD5(CapUser, StrLen(CapUser)) != User ) OR ( MD5(CapPass, StrLen(CapPass)) != Pass )
{
   MsgBox, Wrong credentials entered.  Exiting.
   ExitApp
}
MsgBox, You reached here - correct!
Return


MD5( ByRef V, L=0 ) { ; www.autohotkey.com/forum/viewtopic.php?p=275910#275910
 VarSetCapacity( MD5_CTX,104,0 ), DllCall( "advapi32\MD5Init", Str,MD5_CTX )
 DllCall( "advapi32\MD5Update", Str,MD5_CTX, Str,V, UInt,L ? L : VarSetCapacity(V) )
 DllCall( "advapi32\MD5Final", Str,MD5_CTX )
 Loop % StrLen( Hex:="123456789ABCDEF0" )
  N := NumGet( MD5_CTX,87+A_Index,"Char"), MD5 .= SubStr(Hex,N>>4,1) . SubStr(Hex,N&15,1)
Return MD5
}