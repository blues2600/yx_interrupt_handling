include		environment.inc		; 编程环境声明

.data
.code

; 名称：	binary_search
; 功能：	查询中断向量表地址
; 参数： pPage_table:ptr dword
;		query_value:dword
;		number_size:dword
;		table_size:dword
; 要求： 表的内容按照升序排列
; 实现： 使用对半查找将query_value与表格中的值对比
; 返回：	如果成功则EAX = 中断处理程序指针，否则返回0

binary_search proc
					pPage_table		equ		[ebp+8]			;表指针
					query_value		equ		[ebp+12]		;查询值，中断信号
					member_size		equ		[ebp+16]		;表项大小
					table_size		equ		[ebp+20]		;表的元素个数

					first			equ		[ebp-4]			;第一个元素下标
					last			equ		[ebp-8]			;最后一个元素下标
					mid				equ		[ebp-12]		;中间元素下标

					push			ebp
					mov				ebp,esp
					sub				esp,12
					push			ebx
					push			edx
					push			edi

					;初始化
					mov  eax,0
					mov	 first,eax				; first = 0
					mov	 eax,table_size			; last = (table_size - 1)
					dec	 eax
					mov	 last,eax
					mov	 edi,query_value		; EDI = searchVal
					mov	 ebx,pPage_table		; EBX = 表指针

				start: ; while first <= last
					mov	 eax,first
					cmp	 eax,last
					ja	 err					; 退出查找

					; mid = (last + first) / 2
					mov	 eax,last
					add	 eax,first
					shr	 eax,1
					mov	 mid,eax

					; EDX = 中间元素的值
					mov	 edx,0
					mul	 dword ptr member_size				; eax * mid
					mov	 edx,[ebx+eax]				; EDX = 中间元素的值

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
				L3:	mov	 eax,mid  				; 找到要查询的值，中断信号
					mov  edx,0					; 下标 * 元素大小
					mul  dword ptr member_size
					add  eax,ebx				; 元素地址
					add  eax,4					; 返回中断处理程序地址
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

; binary search Java 实现
class Solution {
    public int search(int[] nums, int target) {
        int left = 0, right = nums.length - 1;
        while (left <= right) {
            int mid = (right - left) / 2 + left;
            int num = nums[mid];
            if (num == target) {
                return mid;
            } else if (num > target) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return -1;
    }
}

;作者：LeetCode-Solution
;链接：https://leetcode.cn/problems/binary-search/solution/er-fen-cha-zhao-by-leetcode-solution-f0xw/
;来源：力扣（LeetCode）
;著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。