
; 01111011b为二进制标志

mov     al,123             ;al = 01111011b
and     al,0               ;al = 00000000b
not     al                 ;al = 11111111b
and     al,11111111b       ;al = 11111111b
or      al,0               ;al = 11111111b
not     al                 ;al = 00000000b
or      al,11111111b       ;al = 11111111b
xor     al,11111111b       ;al = 00000000b
xor     al,11111111b       ;al = 11111111b


.data
var         dword   13FE12h                     ;十六进制
var2        word    0A12Bh  
ch          byte    "a"
str         byte    "have a nice day.",0        ;字符串后面通常加0表示结尾
file_name   byte    "c:\\notepad.exe",0
array       byte    100     dup(0)              ;定义100字节的数组，使用0初始化

.code
mov     esi,offset var      ;var的内存地址移动到esi
mov     edi,offset ch       ;ch的内存地址移动到edi



        


NULL = 0                    ;使用等号创建符号常量
TRUE = 1
PI    EQU    3.14           ;使用EQU创建符号常量
table_size	EQU	[ebp+20]	
                            ;使用TEXTEQU创建符号常量
continueMsg    TEXTEQU    <"Do you wish to continue (Y/N)?">


var_1   BYTE    20    DUP(0)            ;20字节，值都为0
var_2   BYTE    20    DUP(?)            ;20字节，值都未初始化
var_3   BYTE    4     DUP（“STACK”）    ;20字节，初始化4个“STACK”字符串常量


                    mov	 eax,first
					cmp	 eax,last
					ja	 err
                    mov	 eax,last
					add	 eax,first
					shr	 eax,1
					mov	 mid,eax

                    ......

                err:mov			eax,0

                    ......

binary_search proc
					pPage_table		equ		[ebp+8]			;表指针
					query_value		equ		[ebp+12]		;查询值，中断信号
					member_size		equ		[ebp+16]		;表项大小
					table_size		equ		[ebp+20]		;表的元素个数
					first			equ		[ebp-4]			;第一个元素下标
					last			equ		[ebp-8]			;最后一个元素下标
					mid				equ		[ebp-12]		;中间元素下标
                    
                    ;序言
					push			ebp
					mov				ebp,esp
					sub				esp,12
					push			ebx
					push			edx
					push			edi
                    ;函数功能代码，省略
                    ;结语
                    pop			edi
					pop			edx
					pop			ebx
					mov			esp,ebp
					pop			ebp
					ret			
binary_search endp


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
;将ecx的值移动到eax指向的位置，即0x00400000位置
mov  dword ptr [eax] , ecx
