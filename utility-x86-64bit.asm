;============================================================================
;  Diviner512, a benchmark for 512-bit division.
;  Copyright (C) 2015 by Zack T Smith.
;
;  This program is free software; you can redistribute it and/or modify
;  it under the terms of the GNU General Public License version 2 as published by
;  the Free Software Foundation.
;
;  This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this program; if not, write to the Free Software
;  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;
;  The author may be reached at 1@zsmith.co.
;=============================================================================

bits	64
cpu	ia64

global	_get_cpuid1_ecx
global	_get_cpuid1_edx
global	_get_cpuid7_ebx
global	_get_cpuid_80000001_ecx
global	_get_cpuid_80000001_edx
global	_get_cpuid_family
global  _get_cpuid_cache_info

; Note:
; Unix ABI says integer param are put in these registers in this order:
;	rdi, rsi, rdx, rcx, r8, r9

	section .text

;------------------------------------------------------------------------------
; Name:         get_cpuid_cache_info
; 
get_cpuid_cache_info:
_get_cpuid_cache_info:
        push    rbx
        push    rcx
        push    rdx
        mov     rax, 4
	mov	rcx, rsi
        cpuid
	mov	[rdi], eax
	mov	[rdi+4], ebx
	mov	[rdi+8], ecx
	mov	[rdi+12], edx
        pop     rdx
        pop     rcx
        pop     rbx
        ret

;------------------------------------------------------------------------------
; Name:		get_cpuid_family
; 
get_cpuid_family:
_get_cpuid_family:
	push	rbx
	push 	rcx
	push 	rdx
	xor	rax, rax
	cpuid
	mov	[rdi], ebx
	mov	[rdi+4], edx
	mov	[rdi+8], ecx
	mov	byte [rdi+12], 0
	pop	rdx
	pop	rcx
	pop	rbx
	ret

;------------------------------------------------------------------------------
; Name:		get_cpuid1_ecx
; 
get_cpuid1_ecx:
_get_cpuid1_ecx:
	push	rbx
	push 	rcx
	push 	rdx
	mov	rax, 1
	cpuid
        mov	rax, rcx
	pop	rdx
	pop	rcx
	pop	rbx
	ret

;------------------------------------------------------------------------------
; Name:		get_cpuid7_ebx
; 
get_cpuid7_ebx:
_get_cpuid7_ebx:
	push	rbx
	push 	rcx
	push 	rdx
	mov	rax, 7
	xor	rcx, rcx
	cpuid
        mov	rax, rbx
	pop	rdx
	pop	rcx
	pop	rbx
	ret

;------------------------------------------------------------------------------
; Name:		get_cpuid1_edx
; 
get_cpuid1_edx:
_get_cpuid1_edx:
	push	rbx
	push 	rcx
	push 	rdx
	mov	rax, 1
	cpuid
        mov	rax, rdx
	pop	rdx
	pop	rcx
	pop	rbx
	ret

;------------------------------------------------------------------------------
; Name:		get_cpuid_80000001_edx
; 
get_cpuid_80000001_edx:
_get_cpuid_80000001_edx:
	push	rbx
	push 	rcx
	push 	rdx
	mov	rax, 0x80000001
	cpuid
        mov	rax, rdx
	pop	rdx
	pop	rcx
	pop	rbx
	ret

;------------------------------------------------------------------------------
; Name:		get_cpuid_80000001_ecx
; 
get_cpuid_80000001_ecx:
_get_cpuid_80000001_ecx:
	push	rbx
	push 	rcx
	push 	rdx
	mov	rax, 0x80000001
	cpuid
        mov	rax, rcx
	pop	rdx
	pop	rcx
	pop	rbx
	ret

