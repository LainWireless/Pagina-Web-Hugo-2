---
author: "Iván Piña Castillo"
date: 2022-10-09
linktitle: Practica 1
title: Práctica 1 - Creación de un sistema automatizado de instalación
---

### Tarea: Creación de un sistema automatizado de instalación
#### Descripción
Se deberá configurar el sistema para que se responda automáticamente a todos los item en la instalación. Las diferentes contraseñas deberán codificarse para que no aparezcan en texto plano. Se trabajará con un esquema lvm creando volúmenes lógicos /, home y var.
1. Instalación basada en fichero de configuración preseed.
- Instalación automatizada basada en medio de almacenamiento extraíble.
- Instalación automatizada con carga de preseed desde red.
2. Instalación basada en preseed/PXE/TFTP

#### Entrega

#### 1. Instalación automatizada basada en medio de almacenamiento extraíble.

Primero nos descargaremos la ISO de Debian con la cual trabajaremos, se puede encontrar en la página oficial.

Luego copiaremos su contenido en una carpeta para después hacer unas modificaciones:

```bash
mkdir /mnt/iso
```


```bash
mount -o loop *iso de Debian* /mnt/iso
```

Moveremos todos los archivos necesarios y crearemos un enlace simbólico que que apuntará al resto:

```bash
mkdir iso-preseed

cd iso-preseed

cp -pr /mnt/iso/install.amd install.amd

cp -pr /mnt/iso/dists dists

cp -pr /mnt/iso/pool pool

cp -pr /mnt/iso/.disk .disk

cp -pr /mnt/iso/isolinux isolinux

ln -s .debian
```

Ahora pasaremos a crear el archivo de respuestas. Lo creamos en nuestro equipo en la ruta *iso-preseed/respuestas_* con el nombre de preseed.cfg

Tendrá el siguiente contenido:

```bash
#_preseed_V1
#### Contents of the preconfiguration file (for bullseye)
### Localization
# Preseeding only locale sets language, country and locale.
d-i debian-installer/locale string es_ES

# The values can also be preseeded individually for greater flexibility.
d-i debian-installer/language string spanish
d-i debian-installer/country string Spain
d-i debian-installer/locale string es_ES.UTF-8
# Optionally specify additional locales to be generated.
#d-i localechooser/supported-locales multiselect es_ES.UTF-8

# Keyboard selection.
d-i keymap select es
d-i keyboard-configuration/toggle select No toggling
d-i console-setup/ask_detect boolean true
d-i keyboard-configuration/modelcode string pc105
d-i keyboard-configuration/layoutcode string es
d-i keyboard-configuration/variantcode string qwerty


### Network configuration
# Disable network configuration entirely. This is useful for cdrom
# installations on non-networked devices where the network questions,
# warning and long timeouts are a nuisance.
#d-i netcfg/enable boolean false

# netcfg will choose an interface that has link if possible. This makes it
# skip displaying a list if there is more than one interface.
d-i netcfg/choose_interface select auto

# To pick a particular interface instead:
#d-i netcfg/choose_interface select eth1

# To set a different link detection timeout (default is 3 seconds).
# Values are interpreted as seconds.
#d-i netcfg/link_wait_timeout string 10

# If you have a slow dhcp server and the installer times out waiting for
# it, this might be useful.
#d-i netcfg/dhcp_timeout string 60
#d-i netcfg/dhcpv6_timeout string 60

# Automatic network configuration is the default.
# If you prefer to configure the network manually, uncomment this line and
# the static network configuration below.
#d-i netcfg/disable_autoconfig boolean true

# If you want the preconfiguration file to work on systems both with and
# without a dhcp server, uncomment these lines and the static network
# configuration below.
#d-i netcfg/dhcp_failed note
#d-i netcfg/dhcp_options select Configure network manually

# Static network configuration.
#
# IPv4 example
#d-i netcfg/get_ipaddress string 192.168.1.42
#d-i netcfg/get_netmask string 255.255.255.0
#d-i netcfg/get_gateway string 192.168.1.1
#d-i netcfg/get_nameservers string 192.168.1.1
#d-i netcfg/confirm_static boolean true
#
# IPv6 example
#d-i netcfg/get_ipaddress string fc00::2
#d-i netcfg/get_netmask string ffff:ffff:ffff:ffff::
#d-i netcfg/get_gateway string fc00::1
#d-i netcfg/get_nameservers string fc00::1
#d-i netcfg/confirm_static boolean true

# Any hostname and domain names assigned from dhcp take precedence over
# values set here. However, setting the values still prevents the questions
# from being shown, even if values come from dhcp.
d-i netcfg/get_hostname string Debian-Preseed-Ivan
d-i netcfg/get_domain string unassigned-domain

# If you want to force a hostname, regardless of what either the DHCP
# server returns or what the reverse DNS entry for the IP is, uncomment
# and adjust the following line.
#d-i netcfg/hostname string somehost

# Disable that annoying WEP key dialog.
d-i netcfg/wireless_wep string
# The wacky dhcp hostname that some ISPs use as a password of sorts.
#d-i netcfg/dhcp_hostname string radish

# If non-free firmware is needed for the network or other hardware, you can
# configure the installer to always try to load it, without prompting. Or
# change to false to disable asking.
d-i hw-detect/load_firmware boolean true

### Network console
# Use the following settings if you wish to make use of the network-console
# component for remote installation over SSH. This only makes sense if you
# intend to perform the remainder of the installation manually.
#d-i anna/choose_modules string network-console
#d-i network-console/authorized_keys_url string http://10.0.0.1/openssh-key
#d-i network-console/password password r00tme
#d-i network-console/password-again password r00tme

### Mirror settings
# Mirror protocol:
# If you select ftp, the mirror/country string does not need to be set.
# Default value for the mirror protocol: http.
#d-i mirror/protocol string ftp
d-i mirror/country string manual
d-i mirror/http/hostname string http.us.debian.org
d-i mirror/http/directory string /debian
d-i mirror/http/proxy string

# Suite to install.
#d-i mirror/suite string testing
# Suite to use for loading installer components (optional).
#d-i mirror/udeb/suite string testing

### Account setup
# Skip creation of a root account (normal user account will be able to
# use sudo).
#d-i passwd/root-login boolean false
# Alternatively, to skip creation of a normal user account.
#d-i passwd/make-user boolean false

# Root password, either in clear text
#d-i passwd/root-password password r00tme
#d-i passwd/root-password-again password r00tme
# or encrypted using a crypt(3)  hash.
d-i passwd/root-password-crypted password $6$rcpTrsdYz4q3DpW9$a06rHhSlx.OyWO/Tpa4bvv80xvr/qM6MTMEEsLqbDFYiyjkmj16Stxad3APIP3ZyvUlcTOaxIt1XP82psnqhk1

# To create a normal user account.
d-i passwd/user-fullname string Usuario
d-i passwd/username string usuario
# Normal user's password, either in clear text
#d-i passwd/user-password password insecure
#d-i passwd/user-password-again password insecure
# or encrypted using a crypt(3) hash.
d-i passwd/user-password-crypted password $6$oneV2f3Hxq54GULj$23nkS0IGKA343LJEZebQd1.25vGKvDCc9Dnm3Fc4TCTsQaIw7hzshAPDUqRY0kLeHEpdkkQtiQy6h9FeWpaAu/
# Create the first user with the specified UID instead of the default.
#d-i passwd/user-uid string 1010

# The user account will be added to some standard initial groups. To
# override that, use this.
#d-i passwd/user-default-groups string audio cdrom video

### Clock and time zone setup
# Controls whether or not the hardware clock is set to UTC.
d-i clock-setup/utc boolean true

# You may set this to any valid setting for $TZ; see the contents of
# /usr/share/zoneinfo/ for valid values.
d-i time/zone string ES/Madrid

# Controls whether to use NTP to set the clock during the install
d-i clock-setup/ntp boolean true
# NTP server to use. The default is almost always fine here.
#d-i clock-setup/ntp-server string ntp.example.com

### Partitioning
d-i partman-auto/disk string /dev/vda
d-i partman-auto/method string lvm
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-lvm/device_remove_lvm_span boolean true
d-i partman-auto/purge_lvm_from_device boolean true
d-i partman-auto-lvm/new_vg_name string VG01
d-i partman-auto-lvm/guided_size string max
d-i partman-md/device_remove_md boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto/expert_recipe string \
    custom :: \
            500 500 500 ext2 \
                    $primary{ } \
                    $bootable{ } \
                    method{ format } \
                    format{ } \
                    use_filesystem{ } \
                    filesystem{ ext2 } \
                    mountpoint{ /boot } . \
            \
            100 1000 -1 lvm \
                    $primary{ } \
                    $defaultignore{ } \
                    method{ lvm } \
                    device{ /dev/vda } \
                    vg_name{ VG01 } . \
            \
            5000 15000 10000 xfs \
                    $lvmok{ } \
                    in_vg{ VG01 } \
                    lv_name{ root } \
                    method{ format } \
                    format{ } \
                    use_filesystem{ } \
                    filesystem{ xfs } \
                    mountpoint{ / } . \
            \
            2000 3000 10000 xfs \
                    $lvmok{ } \
                    in_vg{ VG01 } \
                    lv_name{ var } \
                    method{ format } \
                    format{ } \
                    use_filesystem{ } \
                    filesystem{ xfs } \
                    mountpoint{ /var } . \
            \
            3000 10000 1000000000 xfs \
                    $lvmok{ } \
                    in_vg{ VG01 } \
                    lv_name{ home } \
                    method{ format } \
                    format{ } \
                    use_filesystem{ } \
                    filesystem{ xfs } \
                    mountpoint{ /home } .

d-i partman-basicfilesystems/no_swap boolean false
d-i partman-auto/choose_recipe select custom
d-i partman-lvm/confirm boolean true
d-i partman/confirm_write_new_label boolean true
d-i partman/choose_partition select Finish partitioning and write changes to disk
d-i partman/confirm boolean true
d-i mdadm/boot_degraded boolean true
d-i partman-md/confirm boolean true
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/confirm_nooverwrite boolean true
d-i apt-setup/cdrom/set-first boolean false
### Apt setup
# Choose, if you want to scan additional installation media
# (default: false).
d-i apt-setup/cdrom/set-first boolean false
# You can choose to install non-free and contrib software.
#d-i apt-setup/non-free boolean true
#d-i apt-setup/contrib boolean true
# Uncomment the following line, if you don't want to have the sources.list
# entry for a DVD/BD installation image active in the installed system
# (entries for netinst or CD images will be disabled anyway, regardless of
# this setting).
#d-i apt-setup/disable-cdrom-entries boolean true
# Uncomment this if you don't want to use a network mirror.
#d-i apt-setup/use_mirror boolean false
# Select which update services to use; define the mirrors to be used.
# Values shown below are the normal defaults.
#d-i apt-setup/services-select multiselect security, updates
#d-i apt-setup/security_host string security.debian.org

# Additional repositories, local[0-9] available
#d-i apt-setup/local0/repository string \
#       http://local.server/debian stable main
#d-i apt-setup/local0/comment string local server
# Enable deb-src lines
#d-i apt-setup/local0/source boolean true
# URL to the public key of the local repository; you must provide a key or
# apt will complain about the unauthenticated repository and so the
# sources.list line will be left commented out.
#d-i apt-setup/local0/key string http://local.server/key
# If the provided key file ends in ".asc" the key file needs to be an
# ASCII-armoured PGP key, if it ends in ".gpg" it needs to use the
# "GPG key public keyring" format, the "keybox database" format is
# currently not supported.

# By default the installer requires that repositories be authenticated
# using a known gpg key. This setting can be used to disable that
# authentication. Warning: Insecure, not recommended.
#d-i debian-installer/allow_unauthenticated boolean true

# Uncomment this to add multiarch configuration for i386
#d-i apt-setup/multiarch string i386


### Package selection
#tasksel tasksel/first multiselect standard, web-server, kde-desktop

# Or choose to not get the tasksel dialog displayed at all (and don't install
# any packages):
d-i pkgsel/run_tasksel boolean false

# Individual additional packages to install
#d-i pkgsel/include string openssh-server build-essential
# Whether to upgrade packages after debootstrap.
# Allowed values: none, safe-upgrade, full-upgrade
#d-i pkgsel/upgrade select none

# You can choose, if your system will report back on what software you have
# installed, and what software you use. The default is not to report back,
# but sending reports helps the project determine what software is most
# popular and should be included on the first CD/DVD.
popularity-contest popularity-contest/participate boolean false

### Boot loader installation
# Grub is the boot loader (for x86).

# This is fairly safe to set, it makes grub install automatically to the UEFI
# partition/boot record if no other operating system is detected on the machine.
d-i grub-installer/only_debian boolean true

# This one makes grub-installer install to the UEFI partition/boot record, if
# it also finds some other OS, which is less safe as it might not be able to
# boot that other OS.
d-i grub-installer/with_other_os boolean true

# Due notably to potential USB sticks, the location of the primary drive can
# not be determined safely in general, so this needs to be specified:
d-i grub-installer/bootdev  string /dev/vda
# To install to the primary device (assuming it is not a USB stick):
#d-i grub-installer/bootdev  string default

# Alternatively, if you want to install to a location other than the UEFI
# parition/boot record, uncomment and edit these lines:
#d-i grub-installer/only_debian boolean false
#d-i grub-installer/with_other_os boolean false
#d-i grub-installer/bootdev  string (hd0,1)
# To install grub to multiple disks:
#d-i grub-installer/bootdev  string (hd0,1) (hd1,1) (hd2,1)

# Optional password for grub, either in clear text
#d-i grub-installer/password password r00tme
#d-i grub-installer/password-again password r00tme
# or encrypted using an MD5 hash, see grub-md5-crypt(8).
#d-i grub-installer/password-crypted password [MD5 hash]

# Use the following option to add additional boot parameters for the
# installed system (if supported by the bootloader installer).
# Note: options passed to the installer will be added automatically.
#d-i debian-installer/add-kernel-opts string nousb

### Finishing up the installation
# During installations from serial console, the regular virtual consoles
# (VT1-VT6) are normally disabled in /etc/inittab. Uncomment the next
# line to prevent this.
#d-i finish-install/keep-consoles boolean true

# Avoid that last message about the install being complete.
d-i finish-install/reboot_in_progress note

# This will prevent the installer from ejecting the CD during the reboot,
# which is useful in some situations.
#d-i cdrom-detect/eject boolean false

# This is how to make the installer shutdown when finished, but not
# reboot into the installed system.
#d-i debian-installer/exit/halt boolean true
# This will power off the machine instead of just halting it.
#d-i debian-installer/exit/poweroff boolean true

### Preseeding other packages
# Depending on what software you choose to install, or if things go wrong
# during the installation process, it's possible that other questions may
# be asked. You can preseed those too, of course. To get a list of every
# possible question that could be asked during an install, do an
# installation, and then run these commands:
#   debconf-get-selections --installer > file
#   debconf-get-selections >> file


#### Advanced options
### Running custom commands during the installation
# d-i preseeding is inherently not secure. Nothing in the installer checks
# for attempts at buffer overflows or other exploits of the values of a
# preconfiguration file like this one. Only use preconfiguration files from
# trusted locations! To drive that home, and because it's generally useful,
# here's a way to run any shell command you'd like inside the installer,
# automatically.

# This first command is run as early as possible, just after
# preseeding is read.
#d-i preseed/early_command string anna-install some-udeb
# This command is run immediately before the partitioner starts. It may be
# useful to apply dynamic partitioner preseeding that depends on the state
# of the disks (which may not be visible when preseed/early_command runs).
#d-i partman/early_command \
#       string debconf-set partman-auto/disk "$(list-devices disk | head -n1)"
# This command is run just before the install finishes, but when there is
# still a usable /target directory. You can chroot to /target and use it
# directly, or use the apt-install and in-target commands to easily install
# packages and run commands in the target system.
#d-i preseed/late_command string apt-install zsh; in-target chsh -s /bin/zsh
```

Ahora vamos a preparar la imagen. Para ello nos desplazaremos hasta la carpeta isolinux que copiamos a iso-preseed en un paso anterior y editamos el archivo txt.cfg para añadirle una nueva línea:

```bash
cd isolinux

nano txt.cfg
```

```bash
default install
label install
        menu label ^Install
        kernel /install.amd/vmlinuz
        append vga=788 initrd=/install.amd/initrd.gz -- quiet
label unattended-gnome
 menu label ^Instalacion Desantendida de IVAN
 kernel /install.amd/gtk/vmlinuz
 append vga=788 initrd=/install.amd/gtk/initrd.gz preseed/file=/cdrom/respuestas/preseed.cfg locale=es_ES console-setup/ask_detect=false keyboard-configuration/xkb-keymap=es --
```

Debido a que hemos realizado cambios en los contenidos de la carpeta islinux, deberemos volver a generar el archivo de sumas de verificación que irá ubicado en la raíz del CD. Ejecutaremos el comando:

```bash
md5sum `find ! -name "md5sum.txt" ! -path "./isolinux/*" -follow -type f` > md5sum.txt
```

En este último paso vamos a generar la imagen iso para utilizarla con los siguientes comandos:

```bash
sudo apt-get install genisoimage

genisoimage -o cd-preseed.iso -l -r -J -no-emul-boot -boot-load-size 4 -boot-info-table -b isolinux/isolinux.bin -c isolinux/boot.cat iso-preseed
```

Tras realizar estos comandos, vemos que se ha creado un archivo nuevo llamada **cd-preseed.iso**

Para que el cliente utilice la iso lo añadiremos como un CD:
![imagen1](/images/1.png)

Activaremos el arranque mediante CD:
![imagen2](/images/2.png)

Como se puede ver en la captura aparece mi instalación desatendida:
![imagen3](/images/3.png)

En esta última captura muestro que se han creado los volúmenes lógicos perfectamente:
![imagen4](/images/4.png)


#### 2. Instalación automatizada con carga de preseed desde red.

Ahora en esta ocasión necesitaremos un servidor Apache ya que haremos la instlación desde un Servidor Web.

Para instalar Apache:

```bash
sudo apt install apache2
```

Deberemos colocar el fichero del preseed en la ruta de nuestro servidor web:

```bash
sudo mv preseed.cfg /var/www/html/preseed.cfg
```

Lo más seguro es que no tengamos el preseed en nuestro servidor web ya que lo acabaremos de crear en una máquina virtual. Para ello nos podemos ayudar de **scp**. Para ello necesitaremos la clave pública de nuestro host en nuestro servidor web.
También tenemos que tener en cuenta de que la máquina servidor y la cliente tienen que tener una interfaz que permitan que estén en la misma red. Con virt-manager es fácil de hacer. En esta ocasión no hay ningún problema si las dejamos con la red NAT default de virt-manager.

Una vez todo esto hecho, arrancaremos la máquina cliente mediante una iso de debian pero nos dirigiremos a Advanced Options y ahí eligiremos Automated Install:
![imagen5](/images/5.png)

Luego tendremos que indicar la ip de nuestro servidor y el archivo preseed:
![imagen6](/images/6.png)

Y con esto ya se estaría realizando una instalación desatendida por red.

#### 3. Instalación basada en preseed/PXE/TFTP.

Para este caso convertiremos nuestro anterior servidor web también en un servidor DHCP y en uno TFTP.
Es importante no utilizar una configuración de interfaz de red con DHCP, por lo que la anterior ya no es válida en su lugar utilizaremos la siguiente tanto para la máquina cliente como la servidor:
![imagen7](/images/7.png)

La IP de nuestro servidor tendremos que configurarla de manera estática, en mi caso le di la 192.168.100.90. La IP de mi host es la 192.168.100.1. Es importante tener estas dos IPs en cuenta para realizar la configuración DHCP. 
Para ello hacemos:
```bash
sudo nano /etc/network/interfaces
```

Y añadimos lo siguiente al fichero:

```bash
allow-hotplug enp1s0
iface enp1s0 inet static
      address 192.168.100.90
      netmask 255.255.255.0
      gateway 192.168.100.1
```

Para acabar reiniciamos la interfaz de red:

```bash
sudo /etc/init.d/networking restart
```

Una vez hecho esto ya podemos comenzar a configurar el servidor.

Primero comenzaremos con el servidor DHCP.

```bash
sudo apt install isc-dhcp-server
```

Configuraremos el fichero _/etc/default/isc-dhcp-server_ de la siguiente manera:
```bash
# Defaults for isc-dhcp-server (sourced by /etc/init.d/isc-dhcp-server)

# Path to dhcpd's config file (default: /etc/dhcp/dhcpd.conf).
DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
#DHCPDv6_CONF=/etc/dhcp/dhcpd6.conf

# Path to dhcpd's PID file (default: /var/run/dhcpd.pid).
#DHCPDv4_PID=/var/run/dhcpd.pid
#DHCPDv6_PID=/var/run/dhcpd6.pid

# Additional options to start dhcpd with.
#   Don't use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=""

# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#   Separate multiple interfaces with spaces, e.g. "eth0 eth1".
INTERFACESv4="enp1s0"
INTERFACESv6=""
```

Seguidamente editamos el fichero _/etc/dhcp/dhcpd.conf_ y añadimos lo siguiente al final del fichero:
```bash
allow booting;

subnet 192.168.100.0 netmask 255.255.255.0 {
  range 192.168.100.10 192.168.100.30;
  option broadcast-address 192.168.100.255;
  option routers 192.168.100.1;
  option domain-name-servers 192.168.100.1;
  next-server 192.168.100.90;
  filename "pxelinux.0";
}
```

Reiniciamos el servicio:
```bash
sudo systemctl restart isc-dhcp-server
```

Hecho todo esto, comenzamos a configurar el servidor TFTP.
Primero lo instalamos:
```bash
sudo apt install tftpd-hpa
```

Descargamos netboot.tar.gz en */srv/tftp* :
```bash
sudo wget https://deb.debian.org/debian/dists/bullseye/main/installer-amd64/current/images/netboot/netboot.tar.gz
```

Lo extraemos:
```bash
sudo tar -xvf netboot.tar.gz
```

Y reiniciamos el servicio:
```bash
sudo systemctl restart tftpd-hpa
```

El archivo de configuración del preseed lo seguimos dejando en el directorio */var/www/html*

En cuanto a nuestra máquina cliente, es importante que el arranque solo pueda hacerse por red y por el disco duro que tiene, nada de CD. Una vez terminada la instalación debemos quitar el arranque por red para una mayor seguridad.
![imagen8](/images/8.png)

Una vez inicado el cliente nos toparemos con esto:
![imagen9](/images/9.png)

Una vez se haya conectado con el servidor deberemos seleccionar la opción de **Advanced Options**:
![imagen10](/images/10.png)

Ahora en el nuevo submenú seleccionamos **Automated Install**:
![imagen11](/images/11.png)

Para terminar introducimos la dirección de nuestro fichero **preseed.cfg** y se nos comenzará a instalar nuestro Debian:

![imagen12](/images/12.png)

