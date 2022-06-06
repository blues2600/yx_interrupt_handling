include		environment.inc		; ��̻�������

.data
.code

; ���ƣ�	binary_search
; ���ܣ�	��ѯ�ж��������ַ
; ������ pPage_table:ptr dword
;		query_value:dword
;		number_size:dword
;		table_size:dword
; Ҫ�� ������ݰ�����������
; ʵ�֣� ʹ�ö԰���ҽ�query_value�����е�ֵ�Ա�
; ���أ�	����ɹ���EAX = �жϴ������ָ�룬���򷵻�0

binary_search proc
					pPage_table		equ		[ebp+8]			;��ָ��
					query_value		equ		[ebp+12]		;��ѯֵ���ж��ź�
					member_size		equ		[ebp+16]		;�����С
					table_size		equ		[ebp+20]		;���Ԫ�ظ���

					first			equ		[ebp-4]			;��һ��Ԫ���±�
					last			equ		[ebp-8]			;���һ��Ԫ���±�
					mid				equ		[ebp-12]		;�м�Ԫ���±�

					push			ebp
					mov				ebp,esp
					sub				esp,12
					push			ebx
					push			edx
					push			edi

					;��ʼ��
					mov  eax,0
					mov	 first,eax				; first = 0
					mov	 eax,table_size			; last = (table_size - 1)
					dec	 eax
					mov	 last,eax
					mov	 edi,query_value		; EDI = searchVal
					mov	 ebx,pPage_table		; EBX = ��ָ��

				start: ; while first <= last
					mov	 eax,first
					cmp	 eax,last
					ja	 err					; �˳�����

					; mid = (last + first) / 2
					mov	 eax,last
					add	 eax,first
					shr	 eax,1
					mov	 mid,eax

					; EDX = �м�Ԫ�ص�ֵ
					mov	 edx,0
					mul	 dword ptr member_size				; eax * mid
					mov	 edx,[ebx+eax]				; EDX = �м�Ԫ�ص�ֵ

					; if ( EDX < query_value(EDI) )
					;	first = mid + 1;
					cmp	 edx,edi
					jae	 L2
					mov	 eax,mid				; first = mid + 1
					add	 eax,1
					mov	 first,eax
					jmp	 loop_point

					; else if( EDX > query_value(EDI) )
					;	last = mid - 1;
				L2:	cmp	 edx,edi
					jbe	 L3
					mov	 eax,mid				; last = mid - 1
					sub	 eax,1
					mov	 last,eax
					jmp	 loop_point

					; else return mid
				L3:	mov	 eax,mid  				; �ҵ�Ҫ��ѯ��ֵ���ж��ź�
					mov  edx,0					; �±� * Ԫ�ش�С
					mul  dword ptr member_size
					add  eax,ebx				; Ԫ�ص�ַ
					add  eax,4					; �����жϴ�������ַ
					jmp	 return						; return (mid)

		loop_point:	jmp	 start
				
				err:mov			eax,0
				return:
					pop			edi
					pop			edx
					pop			ebx
					mov			esp,ebp
					pop			ebp
					ret			16
binary_search endp
end