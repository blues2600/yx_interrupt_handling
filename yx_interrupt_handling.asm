

;********************************************************************
;
;				名称：yx_interrupt_handling
;				功能：CPU中断处理程序
;				说明：不考虑硬件，使用纯软件的方式构建中断，本程序用于理解cpu中断机制
;				创建时间：2022年5月28日
;				作者：yx
;
;********************************************************************

include		environment.inc
include		Irvine32.inc
include		win32.inc
extern binary_search@0:proc								;对半查找过程
binary_search equ binary_search@0

.data 
signal						dword		0				;中断信号
fpu_mmx_register			byte		512		dup(0)	;保存fpu mmx寄存器组
interrupt_vector_table		dword		0,123h			;中断向量表
member_size	= ($ - interrupt_vector_table)				;中断向量表项大小
							dword		11,123h
							dword		21,1ABh
							dword		31,123h
							dword		41,123h
							dword		51,123h
							dword		61,123h

.code


;		**** 技术说明 ****
;	
;	写在前面：由于中断处理需要硬件介入，所以在本程序中存在许多假设

;	中断发生时上下文的保存：
;		在检测到中断后，假设自动cpu保存当前eip的值，并且在中断返回时它能够自动恢复eip的值
;		保存其他上下文的工作则由中断处理程序来处理

;	cpu的中断处理过程：
;		cpu检测到中断存在 - 保存当前eip - 将eip指向中断处理程序

;	中断处理程序的工作过程：
;		保存当前上下文 - 根据signal查询中断向量表 - 根据查询结果调用中断服务程序 - 中断服务程序执行完成 - 恢复上下文 - cpu恢复中断前的eip
;
;	机器平台：x86 32bit
;	中断信号：引发中断的设备ID、预定义的中断信号
;	中断信号的存储和传递：
;		cpu检测到中断后，中断处理程序必须根据中断信号来选择中断服务程序
;		在本程序中，约定在变量signal中存储中断信号。中断处理程序默认从signal读取中断信号的值。
;		当一个进程或IO设备请求中断，它通过修改signal的值来完成。
					
;	中断处理程序本身的几个问题：
;		从源代码的角度看中断处理程序是一个过程，但从CPU运行的角度，中断处理程序不会具备完整的过程特征，
;		甚至不被当做一个过程来执行。首先，它不会有参数（无法传递），此外中断处理程序没有返回，也就是说它实际上仅是一段二进制代码。
;		
;	这个程序的缺失部分：
;		cpu必须具备当检测到中断时自动保存当前eip的能力
;		cpu必须事先了解中断处理程序的地址
;		当中断处理程序完成后，要么由中断处理程序恢复中断前的eip，要么由cpu自己恢复
;		以上部分都依赖硬件的支持和配合
;		有一些控制寄存器和调试寄存器没有纳入其中，因为构建本程序的主要目的在于理解中断机制
;		加上自己希望尝试构建一个中断处理程序，所以忽略了其他部分的细节

main PROC

	;保存上下文，忽略了部分寄存器组
	pushad							;通用寄存器组
	pushfd							;eflags
	fxsave		fpu_mmx_register	;用户模式无法通过汇编
	push		gs
	push		fs
	push		es
	push		ss
	push		ds
	push		cs

	;查询中断向量表
	push		7								;表的元素个数
	push		8								;表项大小
	push		21								;查询的值
	push		offset interrupt_vector_table	;中断向量表指针
	call		binary_search

	; 此时eax = 中断服务程序地址
	; 执行中断服务程序，需要硬件介入

	;恢复上下文
	pop			cs				;段寄存器的修改无法通过汇编
	pop			ds
	pop			ss
	pop			es
	pop			fs
	pop			gs
	fxrstor	fpu_mmx_register	;用户模式无法通过汇编
	popfd
	popad

		
	invoke		ExitProcess,0
main ENDP
END main