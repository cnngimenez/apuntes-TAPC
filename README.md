**Apuntes del Curso Tópicos Avanzados en Programación Concurrente**

![GitHub last commit](https://img.shields.io/github/last-commit/cnngimenez/apuntes-AILP) 
![Creative Commons-Attribution-Share Alike 4.0](https://img.shields.io/badge/License-CC--By--SA%204.0-informational?style=flat&logo=creative-commons)

Código Ada: ![GPL Licensed](https://img.shields.io/badge/License-GPLv3-informational?logo=gnu) ![Ada Version](https://img.shields.io/badge/Ada-2012-informational)


- Ver apunte : https://cnngimenez.github.io/apuntes-TAPC/
- Códigos extraídos del apunte: (ver `tangled/*`)
  - Ada: https://github.com/cnngimenez/apuntes-TAPC/tree/master/tangled/ada
  
# Compilar código de Ada
Se requiere un compilador de Ada compatible con GNAT y GPRBuild. Se puede instalar desde los repositiorios en la mayoría de las distribuciones *BSD y GNU/Linux.

Los siguientes comandos de terminal compilarán todos los códigos Ada:

```
cd tangled/ada
gprbuild tapc.gpr -p
```

En `tangled/ada/bin/` se encontrarán los programas binarios listo para ejecutarse.

# Licencia
![CC-By-SA 4.0](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)

Excepto las bibliotecas javascript, hojas de estilo CSS y donde se indique lo contrario. La presente obra se encuentra bajo la [licencia de Creative Commons Reconocimiento-CompartirIgual 4.0 Internacional](http://creativecommons.org/licenses/by-sa/4.0/).

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/) except the presentation, libraries, CSS stylesheets and where otherwise noted.
