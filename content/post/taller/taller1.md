---
author: "Iván Piña Castillo"
date: 2022-10-06
linktitle: Taller 1
title: Taller 1 - Instalación de Debian 11 en el equipo de trabajo
---

### Tarea: Instalación de Debian 11 en el equipo de trabajo
#### Descripción
Describe de forma detallada los pasos que has seguido para la instalación y configuración de Debian bullseye en tu portátil. Comenta las incidencias encontradas, y procedimientos empleado en su solución.
Utiliza un lenguaje claro y técnico.

#### Entrega
Al instalar **Debian 11** en un **disco externo de 1TB** he tenido algún que otro problema a la hora de que el ordenador reconociese una vez ya instalado Debian que en el disco se encontraba el sistema operativo.

El paso de instalar Debian en el disco externo fue fácil, solo me encontré con un error en el *grub-dummy* ya que no le estaba dando el sistema de ficheros adecuados a la partición boot.

Paso a explicar como está instalado mi sistema.
#### Particiones:

| Partición | Tamaño | Sistema de ficheros |
|-----------|--------|---------------------|
| LVM /         | 50 GB  | xfs                 |
| EFI       | 100 MB |                     |
| /boot     | 1 GB   | ext2                |
| LVM /home     | 60 GB  | xfs                 |
| LVM /var      | 200 GB | xfs                 |
| SWAP      | 4 GB   |                     |


He elegido el sistema de ficheros xfs ya que es bastante rápido. El resto del disco duro está dentro del grupo de volumen lógico llamado VG02, así en un futuro se podrá expandir cualquiera de los otros volúmenes lógicos. Para el entorno gráfico he elegido xfce, para que así me vaya el SO lo más fluido posible ya que al estar instalado en un disco extraíble va un poco más lento.

Para resolver el único problema que tuve la solución fue instalar un Debian 11 pero esta vez en el disco duro del ordenador de sobremesa del instituto. Decidí formatear el disco, eliminado Windows.
#### Particiones:

| Partición | Tamaño | Sistema de ficheros |
|-----------|--------|---------------------|
| LVM /         | 30 GB  | xfs                 |
| EFI       | 100 MB | FAT32               |
| /boot     | 1 GB   | ext2                |
| LVM /home     | 40 GB  | xfs                 |
| LVM /var      | 100 GB | xfs                 |
| SWAP      | 4 GB   |                     |



Al terminar la instalación, el GRUB del SO del ordenador de clase me reconocía sin problemas mi Debian.
Acto seguido me puse a instalarle los **drivers de la tarjeta de red del ordenador de mi casa y los drivers de nvidia para mi tarjeta gráfica**. Sin problemas los conseguí instalar.

Sin embargo al llegar a casa, mi ordenador tampoco reconocía que en mi disco externo hubiese un S0 instalado. Así que repetí el mismo paso que hice en clase: instalé un Debian en una partición de 10GB que tenía reservada para casos en los que simplemente necesitase un S0 para utilizarlo como GRUB.
#### Particiones:

| Partición | Tamaño | Sistema de ficheros |
|-----------|--------|---------------------|
| /         | 7.4 GB | xfs                 |
| EFI       | 100 MB | FAT32               |
| /boot     | 500 MB | ext2                |
| SWAP      | 2 GB   |                     |

Tras esto al iniciar mi Debian mediante el GRUB del nuevo que instalé en mi equipo, me percaté de otro error. El fstab se había auto configurado de manera que el **UUID del EFI y la SWAP** eran los del Debian que instalé en el PC de clase. Simplemente tuve que cambiarlo por los UUID de los del Debian de mi disco externo.

Tras todo esto, mi Debian funciona perfectamente. Ha sido algo enrevesado pero me esperaba que fuera así ya que ir con un SO instalado en un disco externo puede causar problemas.
