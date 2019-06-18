; ----------------------------------------------------------------------------------------
; Proyecto 1 Arquitectura de computadoras
; Profesor: Jorge Vargas
; ----------------------------------------------------------------------------------------

        global    _start

        section   .text

imprimir:
		mov       rax, 1                  ; System call para escribir
		mov       rdi, 1                  ; Archivo de salida
		mov       rsi, message            ; Direccion de string de salida
		mov       rdx, 13                 ; Numero de bytes
		syscall                           ; Invocar al sistema operativo para escribir
		mov       rax, 60                 ; System call para salir
		xor       rdi, rdi                ; Codigo de salida 0

		syscall                           ; Invocar al sistema operativo para salir
ret
        
        
calculoN:
		dec esi
		call calcularK1
		call calcularK2
		call calcularK3
		call calcularK4
		call calcularsuma
		jnz calculoN
		ret

calcularganancia:
		;D(t) = (i - p) D(t) + M
		mov rax, 1
		ret

calcularK1:
		push yactual
		;push x0
		call calcularganancia
		ret

calcularK2:
		;dydt(tp(n) + (1/2)*h, y0(n) + (1/2)*k1*h);
		;xactualt0 + 0.5 * h
		;yactual + 0.5 * k1 *h
		call calcularganancia
		ret

calcularK3:
		;dydt(tp(n) + (1/2)*h, y0(n) + (1/2)*k2*h);
		;xactualt0 + 0.5 * h
		;yactual + 0.5 * k2 *h
		call calcularganancia
		ret

calcularK4:
		;dydt(tp(n) + h, y0(n) + k3*h)
		;xactualt0 * h
		;yactual + k3 *h
		call calcularganancia
		ret

calcularsuma:
		;suma = yactual + ((1/6)*(k1 + (2*k2) + (2*k3) + k4)*h);
		;yactual = suma
		ret
		
_start: 
		;mov esi, [iteraciones]
		call imprimir
		
        section   .data
          
message:  	db        "Hello, World", 10      ; note the newline at the end
h:		  	dw 		1								; Salto
iteraciones dw		10								;Cantidad de veces a calcular interes
yactual:	dw		90								;Valor de D(0)
t0:  		db 		0								;Variable independiente tiempo

interes:	dw		0.04							; la tasa de interés estimada de inversión (por período)
inflacion:	dw		0.07							; inflación en el período
aporte:		dw		100								; el aporte adicional constante en cada trimestre
