globals [
  num-clusters  ; Esta variable global se puede utilizar para contar agrupaciones si es necesario
]

breed [butterflies butterfly]  ; Definir la raza de patos

butterflies-own [
  time-since-last-found
]

to setup
  clear-all

  set-default-shape butterflies "butterfly"

  ; Crear el parche en la esquina superior izquierda
   ask patch min-pxcor min-pycor [
   set pcolor red  ; Color rojo para el primer parche
  ]

  ; Crear el parche en la esquina inferior derecha
  ask patch max-pxcor max-pycor [
  set pcolor blue  ; Color azul para el segundo parche
  ]

  ; Crear 1 tortuga en la posición del parche rojo
  create-butterflies 1 [
    set size 1
    set color yellow
    set time-since-last-found 999  ; Inicializar el contador
    setxy min-pxcor min-pycor
    pen-down      ; Colocar la tortuga en la esquina superior izquierda
  ]

  reset-ticks
end

to go
  ask butterflies [search]
  tick
end

to search
  ; Rotar dependiendo del tiempo desde que se encontró un parche
  ifelse time-since-last-found <= 20 [
    right (random 181) - 90  ; Giro más amplio
  ] [
    right (random 21) - 10    ; Giro más pequeño
  ]

  forward 1  ; Moverse hacia adelante

  ; Comprobar el color del parche actual
  ifelse pcolor = blue [
    set time-since-last-found 0  ; Reiniciar el contador si se encuentra un parche
    set pcolor red                 ; Cambiar el color del parche encontrado
  ] [
    set time-since-last-found time-since-last-found + 1  ; Incrementar el contador
  ]
end
