---
author: "Iván Piña Castillo"
date: 2022-10-11
linktitle: Articulo 1
title: Vulnerabilidad, Exploit y Payload
---

#  ¿Qué diferencia hay entre exploit, vulnerabilidad y payload?

![Banner](https://img.freepik.com/vector-premium/banner-tecnologia-digital-seguridad-abstracta_43778-429.jpg?w=900)

En seguridad informática es muy habitual confundir estos tres conceptos, y por ello vamos a ver que es un exploit, una vulnerabilidad y un payload. Un exploit tiene como objetivo comprometer, romper y explotar vulnerabilidades de los sistemas. 

Debemos tener en cuenta que estos términos son utilizados principalmente cuando realizamos pruebas de penetración o ejercicios de hacking ético. 
¿En qué parte del hacking podemos encontrarnos con estos términos?
Lo vemos en la fase de explotación, es decir, una vez que conocemos las características del sistema que tienen las máquinas a las que queremos acceder, podemos investigar si existen vulnerabilidades para esos sistemas, y en el caso afirmativo, (que de costumbre es que sí) sería el momento de buscar algún exploit para romper dicha vulnerabilidad.

Pero vamos a ver cada uno de ellos y como se interrelacionan

## ¿Qué es un exploit?

Un exploit es la herramienta(software) con la cual el hacker aprovechará para comprometer, romper y explotar una vulnerabilidad de seguridad del sistema para sus propios fines.

Esto sucede ya que algunos fabricantes suelen tener fallas de seguridad en sus productos, como por el ejemplo el exploit de día cero, denominado así cuando el desarrollador del producto desconoce de una vulnerabilidad que solo el ciberdelincuente conoce.

[Exploit](https://www.elcursodelhacker.com/wp-content/uploads/2021/06/exploit2022-1.png)

Los ciberdelincuentes aplican ingeniería inversa para analizar toda la programación de dicho sistema, de este modo pueden detectar algún error de código y explotarlo.

### Tipos

- Exploit remoto:
Se realizan mediante una conexión víctima con el atacante, todo mediante una red de comunicaciones.
Por ejemplo, una conexión por internet, por lo general este tipo de ataque suele hacerse mediante el envío y la instalación del software malicioso en el dispositivo.

[Exploit](https://assets.website-files.com/5ff66329429d880392f6cba2/61c43d47dccfe68a303551d4_exploit%20Preview.png)

- Exploit local:
La principal diferencia con el anterior tipo es que se necesita acceso al sistema antes de efectuar un ataque de explotación. Se necesita burlar al sistema para escalar privilegios en el sistema, donde el ciberdelincuente podría controlar al final todo el sistema.

- Exploit en cliente:
Para realizar este tipo de ataques suele influir mucho el phishing para poder comprometer la máquina víctima con un exploit.
Esto se realiza principalmente en las estaciones de trabajo de una organización atacando los softwares de ofimática mediante envío de malware por correos electrónicos.
La mayoría de veces suele ser un éxito, ya que algunos cortafuegos o antivirus dan por alto estos ataques, de este modo los ciberdelincuentes empiezan a escalar privilegios hasta obtener el control total del sistema, aquí podemos llegar a la conclusión de que las víctimas dan el acceso.

Un claro ejemplo explot fue el llamado Eternal Blue, que se aprovechó de la vulnerabilidad en el protocolo SMB en la versión 1, que estaba presente en todos los sistemas operativos de windows, desde su versión 95 al 10. Es capaz de brindarnos control total de una máquina, otorgando la capacidad de ejecutar código a nivel administrador.


## ¿Qué es la vulnerabilidad?

[vulnerabilidad](https://netcloudengineering.com/wp-content/uploads/2017/06/vulnerabilidades-ciberseguridad.jpg)

Una vulnerabilidad  es una debilidad o un error en el código de un sistema que puede ser explotado para obtener acceso no autorizado o realizar acciones no autorizadas en un sistema informático comprometer la seguridad permitiendo a los atacantes ejecutar código, acceder a la memoria de un sistema, instalar malware y robar, destruir o modificar datos confidenciales. 

### Ejemplos de vulnerabilidad

- Autenticación rota:
En la autenticación rota, cada vez que un usuario inicia sesión en su cuenta, se crea una identificación de sesión, y esa identificación de sesión solo se permite para esa cuenta en particular. En caso de que la aplicación web no esté diseñada de forma segura, el atacante puede usar varias técnicas dadas:

   - Relleno de credenciales
   - Contraseñas sin cifrar
   - Tiempos de espera de sesión mal configurados

- Inyección de SQL:
Es un tipo de vulnerabilidad en la que un atacante inserta su propio código en un sitio web con el fin acceder a datos protegidos o sensibles.

- Secuencias de comandos entre sitios:
Son un tipo de vulnerabilidad de los sitios web, que permite que los atacantes coloquen secuencias de comandos maliciosas en páginas web.

[Vulnerabilidad](https://academy.avast.com/hs-fs/hubfs/What_is_scross-site_scripting-1.png?width=600&name=What_is_scross-site_scripting-1.png)

- Falsificación de solicitudes entre sitios:
Es un ataque contra aplicaciones hospedadas en web en las que una aplicación web malintencionada puede influir en la interacción entre un explorador cliente y una aplicación web que confía en ese explorador.

- Configuración incorrecta de seguridad:
Son controles de seguridad que se configuran incorrectamente o se dejan inseguros, lo que pone en riesgo sus sistemas y datos.

## ¿Qué es el payload?

En informática, un payload es una carga de capacidad en un paquete o en otros medios de transmisión. Dicho término está arraigado en el mundo militar y a veces está asociado con la capacidad de código malicioso con el fin de dañar. Podemos encontrarnos con data payloads o malware payload. Del primero podemos decir que se produce cuando el dato es enviado por un destino de comunicación, y el segundo es un código malicioso que pretende hacer daño al objetivo señalado.

[payload](https://esgeeks.com/media/2022/03/Concepto-payload-carga-útil.jpg)

### Ejemplos

Un ejemplo de Data pyload sería a través de un paquete IP. Este puede contener un payload con comandos emitidos por el último usuario, como una solicitud de un contenido web. Aunque, a menudo, consiste en transmitir datos por un servidor en respuesta a un usuario solicitante.  Los límites de los payloads en las PDUs (Protocol Data Unit) son con frecuencia especificados por un protocolo, y el tamaño máximo para un PDU individual raramente cambia.

[icono](https://cdn-icons-png.flaticon.com/512/1995/1995756.png)

El tamaño máximo de payloads por paquetes de IP está limitado por el campo de longitud total (total length) en la cabecera del paquete IP; este campo tiene una longitud de 16 bits, lo que significa que el valor máximo posible es 2¹⁶ y el  valor más alto posible para la longitud del paquete es de 65535, menos del número de bytes que requiere un encabezado de paquete. El MTU para paquetes IP varía por el sistema y la red. La IP original estándar especifica que todos los hosts deben ser capaces de aceptar paquetes tan largos como sean de 576 bytes con los payload data de 512 bytes y los 64 de la cabecera. El valor predeterminado MTU actualmente aceptado para paquetes IPv4 es de 1500 bytes por la compatibilidad con los segmentos Ethernet.

En cuanto a un payload malicioso (o malware payload) podemos poner como ejemplo todos aquellos correos electrónicos o incluso SMS que contienen un virus autorreplicante alojado en un enlace. Los atacantes eluden las defensas, mantienen la carga y atacan a la víctima. Esta vía, la de métodos de distribución comprobados, como los emails de suplantación de identidad y los gusanos, pueden adaptarse. Mientras no tenga límites específicos para la capacidad máxima de carga, los actores maliciosos intentarán mantenerlos en un tamaño razonable para evitar ser detectado por herramientas de detección de malware.

Casi ningún tipo de malware puede ser incorporado dentro de un payload con la ayuda de un generador de payload para crear un malware ejecutable. Metasploit incluye recursos para buscar vulnerabilidades de seguridad, incluyendo un generador de payloads, que es una pequeña secuencia de código que comienza en un comando de shell explotable en el objetivo y crea un fichero binario ejecutable para permitir que el payload entre.

Una vez entregado y ejecutado, el proceso de distribución infecta al sistema objetivo, a menos que haya un sistema de detección de malware. Una carga útil puede contener cualquier tipo de malware, incluido el ransomware, el reclutamiento de botnets u otros tipos de virus o gusanos.

[payload](https://www.techtarget.com/searchsecurity/definition/payload)

## Conclusión

Ya con este contexto, podemos decir que un exploit es un pequeño programa o un pedazo de código que se aprovecha o explota de una vulnerabilidad encontrada, mientras que un payload viene siendo esa acción que queremos hacer una vez que hemos explotado la vulnerabilidad.

Tanto el exploit como el payload son pedazos de código que funcionan en conjunto para un fin, que en este caso, sería explotar la vulnerabilidad encontrada.

Y también cabe decir que dentro del mundo del hacking, existen varias herramientas automatizadas, como lo es Metaexploit, que en la práctica nos ayudan a comprender mucho mejor como funciona este par de términos, ya que no necesariamente un exploit está amarrado a un payload y viceversa. Sino que un exploit puede usar varios payloads a fin de tener una shellcon privilegios, crear usuarios, etc.