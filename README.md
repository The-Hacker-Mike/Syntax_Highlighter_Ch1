# Syntax_Highlighter_Ch1

## Descripción del Programa ##
Este programa es un resaltador de sintaxis, convierte un archivo de JSON a un HTML con CSS para tener un color diferente de texto dependiendo del tipo de dato.
Este programa toma un archivo de JSON, lo convierte a un string y con expresiones regulares siguiendo el syntax valido del lenguaje. Hay expresiones regulares para:
* Llave. Ej:"cancion":
          * Valor. Ej: "We are the champions"
          * Operadores como: , | ( | ) | [ | ] | { | } | :
          * Espacios
          * Tabuladores
          * Numeros enteros y decimales
          * Booleanos: true,false
Una nota importate para las expreiones regulares es que siempre se tienen que encontrar al principio del string para no tomar los datos en desorden.
Cada vez que se encuentra una coincidencia con una expresion dentro del cond, se utiliza display para escribir el substring en el archivo de HTML con su respectiva clase y span para evitar el salto de linea del div.
Por último, se llama recursivamente la función con el string modificado desde el último indice de la expresión regular encontrada.

## Performance ##
Originalmente habíamos dado una solución a través de un programa iterativo pero optamos por resolverlo de forma recursiva ya que es una forma mucho más optiva de utilizar en Racket y en programación funcional.La complejidad por tratarse de un programa recursivo es O(n) donde n es el total de caracteres del texto de JSON, este en el peor caso que se da sólo cuando las expresiones regulares ocupen una longitud de uno. Inicialmente el programa iterativo tenía un tiempo de ejecución considerablemente más elongado que nuestro programa final pero este último tiene una velocidad bastante rápida. El número de iteraciones del programa dependerá siempre de la longitud del string que se maneje en el JSON, en nuestro caso el tiempo de ejecución no se extiende demasiado con una duración de 3 milisegundos ya que contamos solo con 3 objetos en con 5 llaves donde una de cada objeto tiene un array.
  
## Mejoras al código ##
Al hacer este código tuvimos el error de empezar a hacer el código sin planeación, esto ocacionó que al final sólo utilizamos una función en vez de utilizar pequeñas funciones para cada acción a realizar. Si hubieramos planeado antes de empezar a hacer el código, nos hubieramos dado cuenta que teníamos que hacer estas acciones en donde pusimos ocupar una función para cada una:
*Obtener como input del usuario la ruta del archivo de JSON y hacerlo string.
*Checar el token con las expresiones regulares.
*Ir construyendo el string para el html.
*Truncar el string y llamar a la función que tenga las condiciónes de las expresiones regulares con el nuevo string truncado.
*Cuando el string este del archivo de JSON este vacio, escribir todo el string a un nuevo archivo HTML.
Los beneficios de utilizar pequeñas funciones son bastantes, "breaks down the problem" esto se refiere que muchas veces el problema a resolver puede parecer muy complejo pero al romperlo en pequeñas acciones se resuleva más fácil, el cógido esta más limpio, es más fácil hacer modificaciones, es más entendible para otras personas que en algún momento tengan que dar mantenimiento al código, es menos propenso a errores, hacemos el código más rápido.

## Conclusiones ##
Todos los programas recursivos pueden también ser iterativos, esta clase nos ayudo a ver las ventajas de la recursión. Primero, se utilizan menos lineas de código y eso hace el código mucho más entendible. Elegir cuál usar depende de la situación, en este caso, era mucho más entendible y menos complejo a hacer el código de manera recursiva, además, los estados no mutan. Por último, tambien aprendimos que es mucho mejor utilizar pequeñas funciones que tratar de menter todas las tareas en una sola.

 Markup : * Bullet list
              * Nested bullet
                  * Sub-nested bullet etc
          * Bullet list item 2
