

mov  edx , 1
mov  ecx , 1
mov  ebx , 1
mov  eax , 10h
sub  eax , 10h      ;eax - 10h = 0
add  eax , ebx      ;eax + ebx = 1
inc  edx            ;edx + 1 = 2
dec  ecx            ;ecx - 1 = 0


mov  eax , 16               ;十进制
mov  eax , 0x10             ;十六进制
mov  eax , 10h              ;十六进制
mov  eax, 0A12Bh            ;十六进制
mov  eax , 0110101110b      ;二进制




mov  eax , 1  	            ;将数值1移动到eax寄存器
mov  eax , ebx              ;将ebx的值移动（复制）到eax

;将内存地址 0x00400000 的数据移动（复制）到eax
;dword ptr 意味着地址0x00400000的数据是一个dword
mov  eax , dword ptr [0x00400000]     

mov  eax , 400000h          ;将数值0x00400000移动到eax

;将eax的值视为一个内存地址，此时eax是一个指针
;将ecx的值移动到ecx指向的位置，即0x00400000位置
mov  dword ptr [eax] , ecx
