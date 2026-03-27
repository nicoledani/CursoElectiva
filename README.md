# Curso Desarrollo Móvil

## Taller 1: Fundamentos de Flutter y Manejo de Estado

### **Descripción del Taller**
Este taller tiene como objetivo desarrollar una aplicación móvil básica en Flutter, aplicando conceptos fundamentales como:

- **Gestión de Estado:** Uso de `StatefulWidget` junto con la función `setState()` para actualizar dinámicamente el título de la AppBar y reflejar cambios en la interfaz.  

- **Diseño de Layouts:** Organización de elementos mediante `Column`, `Row`, `Padding` y `SizedBox` para lograr una disposición clara y visualmente agradable.  

- **Manejo de Imágenes:** Implementación de imágenes desde la web (`Image.network`) y desde recursos locales (`Image.asset`).  

- **Interactividad:** Botones interactivos (`ElevatedButton` y `ElevatedButton.icon`) que permiten alternar el título de la AppBar y mostrar retroalimentación mediante `SnackBar`.  

- **Widgets Adicionales:** Se implementó un `Container` con borde y colores personalizados y un `GridView` para mostrar elementos de manera organizada.

---

### **Datos del Estudiante**

- **Nombre completo:** Nicolle Daniela Valverde Gallego
- **Código de estudiante:** 230231014  
- **Materia:** Electiva Profesional 1 – Desarrollo Móvil  
- **Taller:** Taller 1 – Flutter  

---

### **Pasos para Ejecutar la Aplicación**

-**Instalar dependencias:** Desde la raíz del proyecto, ejecuta:
    ```bash
    flutter pub get 
    ```
- **Verificar dispositivos:** Confirmar que este un emulador encendido o un dispositivo físico conectado.
    ```Bash
    flutter devices
    ```
- **Ejecutar aplicación:** Para ejecutar el proyecto en modo debug:
    ```Bash
    flutter run
    ```