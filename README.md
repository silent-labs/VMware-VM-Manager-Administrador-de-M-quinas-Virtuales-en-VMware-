# 🖥️ VMware-Manager-BAT

Un script **Batch (.bat)** para administrar máquinas virtuales en **VMware Workstation** de forma rápida e interactiva desde la terminal de Windows.

## 🚀 Características

✅ **Detener máquinas virtuales en ejecución**\
✅ **Encender máquinas virtuales mediante una selección gráfica**\
✅ **Mostrar el estado de todas las máquinas virtuales**\
✅ **Configurar la ruta de VMware Workstation**\
✅ **Escaneo automático de archivos .vmx en la carpeta de VMs**

## 📦 Instalación y Uso

1. **Clona el repositorio**:
   ```sh
   git clone https://github.com/tuusuario/VMware-Manager-BAT.git
   cd VMware-Manager-BAT
   ```
2. **Ejecuta el script**:
   ```sh
   VMware-Manager.bat
   ```
3. **Configura la ruta de VMware** (si no está en la ubicación por defecto).
4. **Selecciona una opción del menú**.

## 🛠️ Dependencias

- **Windows 10/11**
- **VMware Workstation instalado**
- **PowerShell habilitado** (para el diálogo de selección de VMs)

## 🖥️ Funcionalidades

### 1️⃣ **Detener una Máquina Virtual**

Muestra una lista de las máquinas virtuales en ejecución y permite detener una seleccionándola con un número.

### 2️⃣ **Encender una Máquina Virtual**

Escanea las máquinas virtuales disponibles y muestra un **diálogo gráfico** para seleccionar la que se quiere encender.

### 3️⃣ **Mostrar el Estado de las VMs**

Lista todas las máquinas virtuales disponibles en la carpeta configurada y muestra si están **En ejecución**, **Suspendidas** o **Detenidas**.\


## 📌 Notas

- Si tienes tus VMs en una carpeta distinta, puedes modificar la variable `vmFolder` en el script.
- Se recomienda ejecutar el script con **privilegios de administrador** para evitar problemas de permisos.

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas! Si deseas mejorar este script, haz un **fork**, crea una rama y envía un **pull request**.

## 📜 Licencia

Este proyecto está bajo la licencia **MIT**.

---

💻 Desarrollado con ❤️ por Silent Labs

