


Function GetKeyPressed(x as Integer)
    Local result as integer
    If GetRawKeyPressed(x) then result = 1
EndFunction result

Function GetKeyState(x as Integer)
    Local result as integer
    If GetRawKeyState(x) then result = 1
EndFunction result



Function GetJoyPressed(x as integer)
    Local result as Integer
    If GetRawJoystickExists(1) 
        If GetRawJoystickButtonPressed(1,x) then result = 1
    EndIf
Endfunction result

Function GetJoyState(x as integer)
    Local result as Integer
    If GetRawJoystickExists(1) 
        If GetRawJoystickButtonState(1,x) then result = 1
    EndIf
Endfunction result

Function GetJoyX()
    Local result as Float
    If GetRawJoystickExists(1) 
        result = GetRawJoystickX(1)
    EndIf
EndFunction result

Function GetJoyY()
    Local result as Float
    If GetRawJoystickExists(1) 
        result = GetRawJoystickY(1)
    EndIf
EndFunction result



Function GetStartPressed()
    Local result as integer
    If GetKeyPressed(KEY_ENTER) or GetJoyPressed(joystickButtonStart) then result = 1
EndFunction result

Function GetESCPressed()
    Local result as Integer
    If Device$ = "windows" and GetKeyPressed(Key_Escape) then result = 1
Endfunction result



