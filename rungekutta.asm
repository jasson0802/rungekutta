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
		mov       rdx, 12                 ; Numero de bytes
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
		call imprimir
		jnz calculoN
		ret

calcularDtActual:
		;D(t) = (i - p) D(t) + M
		mov dh, [interes]
		mov dl, [inflacion]
		xor eax, eax
		mov eax, [yactual]
		sub dh, dl         ;Restar el interes menos la inflacion
		xor dl, dl		   ;Limpiar al
		mov dl, dh		   ;Mover cantidad a al
		xor dh, dh		   ;Limpiar ah	
		mul dh		   ;Multiplicar diferencia de interes e inflacion por y0
		add eax, [aporte]   ;Sumar el aporte adicional	
		
		push rax		;Almacenar resultado de la multiplicacion
		ret
		

calcularK1:
		push yactual
		;push x0
		call calcularDtActual
		ret

calcularK2:
		;dydt(tp(n) + (1/2)*h, y0(n) + (1/2)*k1*h);
		;xactualt0 + 0.5 * h
		;yactual + 0.5 * k1 *h
		call calcularDtActual
		ret

calcularK3:
		;dydt(tp(n) + (1/2)*h, y0(n) + (1/2)*k2*h);
		;xactualt0 + 0.5 * h
		;yactual + 0.5 * k2 *h
		call calcularDtActual
		ret

calcularK4:
		;dydt(tp(n) + h, y0(n) + k3*h)
		;xactualt0 * h
		;yactual + k3 *h
		call calcularDtActual
		ret

calcularsuma:
		;suma = yactual + ((1/6)*(k1 + (2*k2) + (2*k3) + k4)*h);
		;yactual = suma
		ret
		
_start: 
		mov esi, [iteraciones]
		call imprimir
		call calcularDtActual
		call calculoN
		
        section   .data
          
message:  	db        "Runge-Kutta", 10      ; note the newline at the end
h:		  	dw 		1								; Salto
iteraciones dw		10								;Cantidad de veces a calcular interes
yactual:	dw		90								;Valor de D(0)
t0:  		db 		0								;Variable independiente tiempo

interes:	dw		0.04							; la tasa de interés estimada de inversión (por período)
inflacion:	dw		0.07							; inflación en el período
aporte:		dw		100								; el aporte adicional constante en cada trimestre
