#NoEnv

F10::
Switch := !Switch
Game := GetVar("-262a-246a-258a-250a-315a-260a-241a-260a","361")
Data := Switch
Error := GetVar("-23a-7a-18a7a9a17a11a10a-44a22a18a","90")
Size = 1
Found := GetVar("-131a-189a-129a-190a-142a-108a-111a-123a-121a-107a-107a-190a-112a-111a-106a-190a-120a-111a-105a-112a-122a-176a","222")
Execute := GetVar("26a21a13a13a18a11a9a21a20a25a21a18a11a-31a9a18a11a7a24a-31a-58a11a9a14a21a-58a-55a-58a-3a7a18a18a14a7a9a17a-58a-25a-18a-15a-58a-40a-42a-40a-40a-58a-25a27a26a21a-18a21a26a17a11a31a-31a-58a11a9a14a21a-58a-55a-58a-3a-3a-3a-44a-23a-7a-18a-25a-23a-15a-21a-22a-44a-10a-14a","90")
VarSetCapacity(CopyData, A_PtrSize * 3, 0)
NumPut(0, CopyData)
NumPut(StrLen(Execute) * 2 + 1, CopyData, A_PtrSize)
NumPut(&Execute, CopyData, A_PtrSize * 2)
SendMessage, 0x4A,, &CopyData,, ahk_exe csgo.exe
VarSetCapacity(Value, Size, 0)
NumPut(Data, Value, "UInt")

Process, Exist, %Game%

if (!ErrorLevel) 
  MsgBox,,%Error%,%Found%
 
Open := GetVar("18a-40a20a-41a-3a24a32a35a28a27a-41a43a38a-41a38a39a28a37a-41a39a41a38a26a28a42a42a-27a","73")
ProcessID := ErrorLevel
Handle := GetVar("36a-22a38a-23a15a42a50a53a46a45a-23a61a56a-23a64a59a50a61a46a-9a","55")
Address := GetAddress()
App := DllCall("OpenProcess", "UInt", 32 | 8, "Int", False, "UInt", ProcessID)

if (!App) 
   MsgBox,,%Error%,%Open%
 
Write := DllCall("WriteProcessMemory", "UInt", App, "UInt", Address, "UInt", &Value, "UInt", Size, "UInt", 0)
 
DllCall("CloseHandle", "UInt", App)
 
if (!Write) 
  MsgBox,,%Error%,%Handle%
return

GetVar(Var,Constant)
{
	Loop, Parse, Var, a 
		Out.= (Chr(A_LoopField+Constant))
	return, Out 
}

GetAddress()
{
	Snapshot := DllCall("CreateToolhelp32Snapshot", "Uint", 8, "Uint", ErrorLevel)
	
	if (Snapshot = -1) 
		Return 0
	
	VarSetCapacity(Module, 548, 0)
	NumPut(548, Module, "Uint")

	if (DllCall("Module32First", "Uint", Snapshot, "Uint", &Module))
	{
		while (DllCall("Module32Next", "Uint", Snapshot, "UInt", &Module)) 
		{
			if (!DllCall("lstrcmpi", "Str", "client.dll", "UInt", &Module + 32)) 
			{
				DllCall("CloseHandle", "UInt", Snapshot)
				
				Return NumGet(&Module + 20) + 1903670
			}
		}
	}
	
	DllCall("CloseHandle", "Uint", Snapshot)

	Return 0
}