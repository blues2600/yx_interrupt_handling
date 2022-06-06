

; win32 api ÉùÃ÷

includelib	"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\um\x86\kernel32.Lib"

AreFileApisANSI proto
ExitProcess proto, dwExitCode:dword
;GetFileSize proto, handle:dword ,filesize:ptr dword
FormatMessageA proto,dwFlags:dword ,lpSource:ptr dword ,dwMessageId:dword ,dwLanguageId:dword ,lpBuffer:ptr dword ,nSize:dword ,Arguments:ptr dword 
CreateFileA proto, lpFilename:PTR BYTE,	dwDesiredAccess:DWORD,	dwShareMode:DWORD,	lpSecurityAttributes:DWORD,  dwCreationDisposition:DWORD,	dwFlagsAndAttributes:DWORD,	hTemplateFile:DWORD		
WriteFile proto ,hFile:dword,lpBuffer:dword,nNumberOfBytesToWrite:dword,lpNumberOfBytesWritten:dword,lpOverlapped:dword
ReadFile proto ,hFile:dword,lpBuffer:dword,nNumberOfBytesToRead:dword,lpNumberOfBytesRead:dword,lpOverlapped:dword
setStr proto,source:ptr byte,endword:dword
SetFilePointer proto,hFile:dword,lDistanceToMove:dword,lpDistanceToMoveHigh:dword,dwMoveMethod:dword
CloseHandle PROTO ,hObject:dword