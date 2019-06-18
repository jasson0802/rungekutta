; ----------------------------------------------------------------------------------------
; Proyecto 1 Arquitectura de computadoras
; Profesor: Jorge Vargas
; r11 guarda el valor temporal de y
; rcx se usa como registro para realizar las multiplicaciones con constantes
; rax se utiliza para cargar las k
; ----------------------------------------------------------------------------------------

        global    _start

        section   .text

imprimir:
		mov       rax, 1                  ; System call para escribir
		mov       rdi, 1                  ; Archivo de salida
		mov       rsi, message            ; Direccion de string de salida
		mov       rdx, 12                 ; Numero de bytes
		syscall                           ; Invocar al sistema operativo para escribir
		mov       rax, 60                 ; System call para salir
		xor       rdi, rdi                ; Codigo de salida 0

		syscall                           ; Invocar al sistema operativo para salir
ret
          
calculoN:
		inc edx
		call calcularK1
		call calcularK2
		call calcularK3
		call calcularK4
		call calcularsuma
		call imprimir
		cmp edx, [iteraciones]
		jle calculoN
		ret

calcularDtActual:
		;D'(t) = (i - p) D(t) + M
		mov r8, [interes]
		mov r9, [inflacion]
		xor rax, rax
		pop rax 			;mov eax, [yactual]
		sub r8, r9         ;Restar el interes menos la inflacion
		mul r8		   		;Multiplicar diferencia de interes e inflacion por yactual
		add rax, [aporte]   ;Sumar el aporte adicional	
		
		mov r11, rax		;Almacenar resultado de la multiplicacion
		ret
		

calcularK1:
		xor rax, rax
		mov eax, dword [yactual]
		push rax
		ret

calcularK2:
		xor rax, rax
		xor rcx, rcx
		pop rax
		push rax
		mov ecx, dword [constanteMul]
		mul ecx ;Multiplicar por 1/2
		mul dword [h]	 ;Multiplicar por salto
		call calcularDtActual ;Obtener y(n)
		add rax, r11   ; Sumar con resultado de multiplicacion
			
		push rax	;Almacenar k2
		
		ret

calcularK3:
		xor rax, rax
		xor rcx, rcx
		pop rax			;Cargar k2 en rax
		push rax	;Almacenar k2 de nuevo en la pila
		mov ecx, dword [constanteMul]
		mul ecx ;Multiplicar por 1/2
		mul dword [h]	 ;Multiplicar por salto
		add rax, r11   ; Sumar con resultado de multiplicacion
		
		push rax
		ret

calcularK4:
		xor rax, rax
		xor rcx, rcx
		pop rax			;Cargar k3 en rax
		push rax		;Almacenar k3 de nuevo en la pila
		mul dword [h]	 ;Multiplicar por salto
		
		push rax
		ret

calcularsuma:
		;suma = yactual + ((1/6)*(k1 + (2*k2) + (2*k3) + k4)*h);
		;yactual = suma
		ret
		
_start: 
		xor rax, rax				;Limpiar registros
		xor rdx, rdx
		mov esi, [iteraciones]		;Setear contador
		call imprimir				;Imprimir
		mov eax, dword [yactual]	;Setear y inicial
		push rax					;Guardar y en pila
		call calcularDtActual		;Calcular y'
		call calculoN				;iniciar ciclo
		
        section   .data
          
message:  	db        "Runge-Kutta", 10      ; note the newline at the end
h:		  	dw 		1								; Salto
iteraciones dw		10								;Cantidad de veces a calcular interes
yactual:	dw		90								;Valor de D(0)
t0:  		db 		0								;Variable independiente tiempo

interes:	dw		0.04							; la tasa de interés estimada de inversión (por período)
inflacion:	dw		0.07							; inflación en el período
constanteMul:	dw		0.5							; Constante de multiplicacion para k
totalMul:	dw		0.16						; Constante de multiplicacion para total. Este numero debe ser 1/6
aporte:		dw		100								; el aporte adicional constante en cada trimestre
