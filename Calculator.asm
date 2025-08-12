section .data
    msg1 db 'Enter first number: ', 0
    len1 equ $ - msg1
    
    msg2 db 'Enter second number: ', 0
    len2 equ $ - msg2
    
    msg3 db 'Choose operation (+, -, *, /): ', 0
    len3 equ $ - msg3
    
    msg4 db 'Result: ', 0
    len4 equ $ - msg4
    
    newline db 10, 0
    
section .bss
    num1 resb 10
    num2 resb 10
    op resb 2
    result resb 10
    
section .text
    global _start
    
_start:
    ; Print message to enter first number
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80
    
    ; Read first number
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 10
    int 0x80
    
    ; Print message to enter second number
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80
    
    ; Read second number
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 10
    int 0x80
    
    ; Print message to choose operation
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 0x80
    
    ; Read operation
    mov eax, 3
    mov ebx, 0
    mov ecx, op
    mov edx, 2
    int 0x80
    
    ; Convert ASCII numbers to integers
    mov eax, [num1]
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0'
    
    ; Perform operation based on user choice
    mov cl, [op]
    cmp cl, '+'
    je addition
    cmp cl, '-'
    je subtraction
    cmp cl, '*'
    je multiplication
    cmp cl, '/'
    je division
    
addition:
    add eax, ebx
    jmp display_result
    
subtraction:
    sub eax, ebx
    jmp display_result
    
multiplication:
    imul eax, ebx
    jmp display_result
    
division:
    xor edx, edx    ; Clear edx for division
    idiv ebx        ; Divide eax by ebx, result in eax
    jmp display_result
    
display_result:
    ; Convert result to ASCII
    add eax, '0'
    mov [result], eax
    
    ; Print result message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, len4
    int 0x80
    
    ; Print result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 10
    int 0x80
    
    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
