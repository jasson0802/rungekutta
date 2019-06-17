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
		  ;yactual = ycalculada;

		calcularganancia:
		;D(t) = (i - p) D(t) + M
		mov rax, 1
		ret
		
		calcularK1:
		mov rax, 1
		ret
		
		calcularK2:
		mov rax, 1
		ret
		
		calcularK3:
		mov rax, 1
		ret
		
		calcularK4:
		mov rax, 1
		ret
		
          section   .data
          
message:  	db        "Hello, World", 10      ; note the newline at the end
h:		  	dw 		1								; Salto
iteraciones dw		10								;Cantidad de veces a calcular interes
yactual:	dw		90								;Valor de D(0)
t0:  		db 		0								;Variable independiente tiempo

interes:	dw		0.04							; la tasa de interés estimada de inversión (por período)
inflacion:	dw		0.07							; inflación en el período
aporte:		dw		100								; el aporte adicional constante en cada trimestre
