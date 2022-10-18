---
author: "Iván Piña Castillo"
date: 2022-10-18
linktitle: Ejercicios Gestión de Paquetería
title: Ejercicios Gestión de Paquetería.
---

# **Ejercicios gestión de paquetería**
## **Trabajo con apt, aptitude, dpkg**
### **Prepara una máquina virtual con Debian bullseye, realizar las siguientes acciones:**

**1. Que acciones consigo al realizar apt update y apt upgrade. Explica detalladamente.**

- **(sudo) apt update:** Actualiza la lista de paquetes disponibles y sus versiones en los
repositorios (/etc/apt/sources.list), aunque no instala nada.
- **(sudo) apt upgrade:** Debe usarse tras el comando anterior, permite instalar, en el caso de no
tener el paquete instalado, y actualizar versiones de los ya instalados. Siempre que sea
posible, esta acción respetará la configuración del software existente.

**2. Lista la relación de paquetes que pueden ser actualizados. ¿Qué información puedes sacar a tenor de lo mostrado en el listado?**

Con el comando **apt list --upgradable** (tras usar apt update) se ven la lista de paquetes que quieres instalar:
![image](/images/paquetes/1.png)

- La primera línea, verde, es el nombre del paquete que tiene una versión actualizada en el repositorio.
- stable-security apunta al repositorio.
- 5.10.46-5 es la versión actualizable o más reciente del paquete.
- amd64 es la arquitectura del sistema.
- Actualizable desde: 5.10.46-4 es la versión del paquete antiguo actualmente instalado.

**3. Indica la versión instalada, candidata así como la prioridad del paquete openssh-client.**

apt policy openssh-clientLa prioridad (500) a más alta más prioridad tiene para el sistema su instalación de ese repositiorio.

4. ¿Cómo puedes sacar información de un paquete oficial instalado o que no este instalado?
• dpkg -s nombre_del_paquete te da mucha información del paquete, si está instalado
• apt show nombre_del_paquete te proporciona la información detallada de arriba, pero sin
necesidad de estar instalado, actualizado los repositorios previamente.
5. Saca toda la información que puedas del paquete openssh-client que tienes actualmente
instalado en tu máquina.
• apt-cache showpkg openssh-client
• Ofrece mucha información, entre ellas dependencias, dependencias reversas, etc.
6. Saca toda la información que puedas del paquete openssh-client candidato a actualizar en tu
máquina.
7. Lista todo el contenido referente al paquete openssh-client actual de tu máquina. Utiliza para
ello tanto dpkg como apt.
• apt-file list openssh-client
• dpkg -L openssh-client8. Listar el contenido de un paquete sin la necesidad de instalarlo o descargarlo.
•
apt-file list nombre_paquete
9. Simula la instalación del paquete openssh-client.
•
apt-get install -s openssh-client
10.¿Qué comando te informa de los posible bugs que presente un determinado paquete?
•
apt-listbugs -s all list nombre_paquete
11.Después de realizar un apt update && apt upgrade. Si quisieras actualizar únicamente los
paquetes que tienen de cadena openssh. ¿Qué procedimiento seguirías?. Realiza esta acción,
con las estructuras repetitivas que te ofrece bash, así como con el comando xargs.
12.¿Cómo encontrarías qué paquetes dependen de un paquete específico.
• apt-cache depends nombre_paquete
• apt-cache rdepends nombre_paquete para las dependencias inversas.
13.¿Cómo procederías para encontrar el paquete al que pertenece un determinado fichero?
• dpkg -S ruta/del/fichero
• apt-file search ruta/del/fichero
14.¿Que procedimientos emplearías para liberar la caché en cuanto a descargas de paquetería?
• apt-get clean ,si añades el parámetro “--dry-run” mostrará los directorios que de los que se
eliminarán los paquetes, pero no lo hará realmente, como una simulación.
• apt autoclean , elimina paquetes de la caché que tienen una versión más moderna disponible
en el repositorio.15.Realiza la instalación del paquete keyboard-configuration pasando previamente los
valores de los parámetros de configuración como variables de entorno.
•
debconf
16.Reconfigura el paquete locales de tu equipo, añadiendo una localización que no exista
previamente. Comprueba a modificar las variables de entorno correspondientes para que la
sesión del usuario utilice otra localización.
• export LANG=en_GB.utf8
• export LANGUAGE=en_GB.utf8
• export LC_ALL=en_GB.utf8
• (sudo) dpkg-reconfigure locales -f --frontend Noninteractive
17.Interrumpe la configuración de un paquete y explica los pasos a dar para continuar la
instalación.
• Podríamos probar con dpkg --configure -a para reparar el sistema.
• Con esto, si no funciona, hay que limpiar la caché:
◦ (sudo) apt-get clean
◦ (sudo) apt-get autoclean
•
Tras lo cual usamos el siguiente comando:
◦ (sudo) apt-get update --fix-missing
•
Y por último intentamos recuperar las dependencias dañadas:
◦ (sudo) apt-get install -f
18.Explica la instrucción que utilizarías para hacer una actualización completa de todos los
paquetes de tu sistema de manera completamente no interactiva
19.Bloquea la actualización de determinados paquetes.
• apt-mark hold nombre_paquete ,esta opción está en Debian11.
• aptitude hold nombre_paquete , “aptitude” hay que instalarlo.Trabajo con ficheros .deb
1. Descarga un paquete sin instalarlo, es decir, descarga el fichero .deb correspondiente. Indica
diferentes formas de hacerlo.
• (sudo) apt-get download nombre_paquete
• si se tiene la url con wget url_paquete
2. ¿Cómo puedes ver el contenido, que no extraerlo, de lo que se instalará en el sistema de un
paquete deb?
• dpkg -c nombre_paquete
si es un .deb
• tar -tf nombre_paquete.tar.gz
3. Sobre el fichero .deb descargado, utiliza el comando ar. ar permite extraer el contenido de
una paquete deb. Indica el procedimiento para visualizar con ar el contenido del paquete
deb. Con el paquete que has descargado y utilizando el comando ar, descomprime el
paquete. ¿Qué información dispones después de la extracción?. Indica la finalidad de lo
extraído.
• ar -tvx nombre_archivo.deb
• extraes :
◦ debian-binary, indica la versión del archivo.
◦ control.tar.xz, contiene scripts de configuración, preinstalación, postinstalación,
preborrado, postborrado, etc.
◦ data.tar.xz, tiene contenido todos los archivos que serán extraídos con la instrucción
dpkg.
4. Indica el procedimiento para descomprimir lo extraído por ar del punto anterior. ¿Qué
información contiene?
•
tar xvf nombre_archivo.tar.xz , contiene lo descrito anteriormente.Trabajo con repositorios
1. Añade a tu fichero sources.list los repositorios de bullseye-backports y sid.
•
En el source.list se añaden las siguientes líneas:
◦ deb https://deb.debian.org/debian bullseye-backports main
◦ deb https://deb.debian.org/debian sid main
2. Configura el sistema APT para que los paquetes de debian bullseye tengan mayor prioridad
y por tanto sean los que se instalen por defecto.
•
Dentro de /etc/apt/preferences.d/ creamos un archivo llamado “preferences.pref” , con sudo
y que contenga lo siguiente(rojo):
3. Configura el sistema APT para que los paquetes de bullseye-backports tengan mayor
prioridad que los de unstable.
•
Igual que el anterior pero añadiendo en el archivo “preferences.pref” lo siguiente:
▪ Package: *
Pin: release a=bullseye-backports
Pin-Priority: 500
▪ Package: *
Pin: release a=unstable
Pin-Priority: 1004. ¿Cómo añades la posibilidad de descargar paquetería de la arquitectura i386 en tu sistema.
¿Que comando has empleado?. Lista arquitecturas no nativas. ¿Cómo procederías para
desechar la posibilidad de descargar paquetería de la arquitectura i386?
• (sudo) dpkg --add-architecture i386
• dpkg --print-foreign-architectures , para listar las soportadas por nuestro sistema. Es el
comando que he encontrado, pero a mi no me muestra nada.
• (sudo) dpkg --remove-architecture i386 , para eliminarla.
5. Si quisieras descargar un paquete, ¿cómo puedes saber todas las versiones disponible de
dicho paquete?
•
(sudo) apt-show-versions nombre_paquete
6. Indica el procedimiento para descargar un paquete del repositorio stable.
•
(sudo) apt-get install -t stable nombre_paquete
7. Indica el procedimiento para descargar un paquete del repositorio de buster-backports.
•
(sudo) apt-get install -t buster-backports nombre_paquete , aunque previamente hay que
tener activado el repositorios de buster-backports en el sources.list
8. Indica el procedimiento para descargar un paquete del repositorio de sid.
•
(sudo) apt-get install -t sid nombre_paquete , al igual que el otro teniendo añadido sid al
sources.list
9. Indica el procedimiento para descargar un paquete de arquitectura i386.
•
(sudo) apt-get install nombre_paquete:arquitectura previamente añadida con los comandos
del ejercicio 4.Trabajo con directorios
1. Que cometidos tienen:
1. /var/lib/apt/lists/
• Características de los repositorios
2. /var/lib/dpkg/available
• Lista de los paquetes que hay.
3. /var/lib/dpkg/status
• Información de los paquetes instalados en el sistema.
4. /var/cache/apt/archives/
•
Archivos .deb instalados.