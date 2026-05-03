# Taller 3 - Segundo plano, asincronía y servicios en Flutter

Este proyecto demuestra la capacidad de Flutter para gestionar múltiples hilos y tareas asíncronas.

## Arquitectura de Procesos

1. **Event Loop (Future)**: Se implementó un escáner de galaxias que utiliza async/await para no bloquear el hilo principal durante la latencia de red simulada.
2. **Intervalos (Timer)**: Una cuenta regresiva para misiones espaciales que gestiona de forma estricta el ciclo de vida del objeto Timer para evitar fugas de memoria.
3. **Concurrencia Real (Isolate)**: Un motor de cálculo físico que delega operaciones matemáticas intensivas a un Isolate de Dart

# Taller 1 - Distribución de APK con Firebase App Distribution

- **Generar APK**  
   Se ejecuta `flutter build apk` en la raíz del proyecto. Se obtiene el archivo `app-release.apk` en `build/app/outputs/flutter-apk/`.

- **Subir a Firebase App Distribution**
  - Acceder a Firebase Console → App Distribution → **Releases**.
  - Arrastrar el APK generado.
  - Seleccionar el grupo de testers `QA_Clase`
  - Subir las **Release Notes**.
  - Publicar la versión.

- **Notificar a los testers**
  - Firebase envía automáticamente un correo electrónico a los miembros del grupo con un enlace de instalación.

- **Instalación por parte del tester**
  - El tester recibe el correo, hace clic en el enlace y acepta la invitación.
  - Se descarga e instala la app en su dispositivo Android (puede requerir permisos de orígenes desconocidos).

- **Actualización a una nueva versión**
  - Se modifica el código (por ejemplo, se cambia la versión en `pubspec.yaml` y en `android/app/build.gradle`).
  - Se genera un nuevo APK con `flutter build apk`.
  - Se sube a Firebase App Distribution como una nueva versión.
  - El grupo `QA_Clase` recibe una nueva notificación para actualizar.

## Publicación

1. **Pre-requisitos locales**
   - Tener Flutter instalado y configurado.
   - Tener acceso al proyecto Firebase.
   - Tener copia local del archivo `google-services.json` en `android/app/`

2. **Actualizar versión**
   - Editar `pubspec.yaml` → `version: 1.0.1+2`.

3. **Generar APK de release**
   ```bash
   flutter clean
   flutter pub get
   flutter build apk
   ```
