# Taller 3 - Segundo plano, asincronía y servicios en Flutter

Este proyecto demuestra la capacidad de Flutter para gestionar múltiples hilos y tareas asíncronas.

## Arquitectura de Procesos
1. **Event Loop (Future)**: Se implementó un escáner de galaxias que utiliza async/await para no bloquear el hilo principal durante la latencia de red simulada.
2. **Intervalos (Timer)**: Una cuenta regresiva para misiones espaciales que gestiona de forma estricta el ciclo de vida del objeto Timer para evitar fugas de memoria.
3. **Concurrencia Real (Isolate)**: Un motor de cálculo físico que delega operaciones matemáticas intensivas a un Isolate de Dart
