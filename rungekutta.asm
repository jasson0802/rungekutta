; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------

          global    _start

          section   .text
          
_start:   mov       rax, 1                  ; system call for write
          mov       rdi, 1                  ; file handle 1 is stdout
          mov       rsi, message            ; address of string to output
          mov       rdx, 13                 ; number of bytes
          syscall                           ; invoke operating system to do the write
          mov       rax, 60                 ; system call for exit
          xor       rdi, rdi                ; exit code 0
          syscall                           ; invoke operating system to exit
          
          
          ;loop iteraciones
          ;push k1
          ;push k2
          ;push k3
          ;push k4
          ;ycalculada = yactual(n) + ((1/6)*(k1 + (2*k2) + (2*k3) + k4)*h);
		  ;ti = ti + h;
		  ;yactual = yp;

		interes:
		
		mov rax, 1
		ret


          section   .data
          
message:  	db        "Hello, World", 10      ; note the newline at the end
h:		  	dw 		0.5								; Salto
iteraciones dw		10								;Cantidad de veces a calcular interes 		

          section .bss
		  korder1: resb 1
		  korder2: resb 1
		  korder3: resb 1
		  korder4: resb 1
		  yactual: resb 1
		  x0:  resb 1

;D(t) = (i - p) D(t) + M
