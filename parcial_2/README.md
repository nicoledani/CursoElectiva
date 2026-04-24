# Smart City Tuluá - Gestión y Estadísticas

Proyecto desarrollado para el **Parcial 2** del curso de Electiva (Sétimo Semestre) en la **UCEVA**. La aplicación permite la gestión integral de establecimientos (parqueaderos) y el análisis masivo de datos de accidentalidad en el municipio de Tuluá.

---

## Tecnologías y APIs

### 1. Fuentes de Datos
* **Módulo de Accidentes:** * **Fuente:** [Portal de Datos Abiertos Colombia](https://www.datos.gov.co/resource/ezt8-5wyj.json).
    * **Endpoint:** `https://www.datos.gov.co/resource/ezt8-5wyj.json`
    * **Campos Clave:** `clase`, `gravedad`, `barrio`, `dia`.
* **Módulo de Establecimientos:** * **Fuente:** API Privada de Gestión de Parqueaderos.
    * **Endpoint:** `https://parking.visiontic.com.co/api/establecimientos`
    * **Funcionalidad:** CRUD completo con soporte de imágenes.

### 2. Respuesta JSON 
**Accidentes:**
json
/*
[
  {
    "clase": "Choque",
    "gravedad": "Solo daños",
    "barrio": "Victoria",
    "dia": "Lunes"
  }
]
**Establecimientos:**
{
  "data": [
    {
      "id": 1,
      "nombre": "Parqueadero Central",
      "direccion": "Calle 25 #12-30",
      "foto": "url_imagen.jpg"
    }
  ]
}  */
### 3. Future/async/await vs Isolate
**Future/Async/Await:** Se utiliza para operaciones de red (I/O Bound). Permite que la aplicación no se bloquee mientras espera la respuesta de la API, delegando la espera al sistema operativo.

**Isolate (Compute):** Se implementó para el procesamiento de los 100,000 registros de accidentes.

**Por qué:** El mapeo y filtrado de grandes volúmenes de datos es una tarea CPU Bound. Al usar Isolate (vía la función compute), este procesamiento ocurre en un hilo separado, evitando que la interfaz de usuario (UI) sufre "jank" o congelamiento durante el cálculo.

### 4. Estructura del proyecto
El proyecto sigue una estructura modular para facilitar el mantenimiento:
* models/: Clases de datos (Accidente, Establecimiento) con serialización JSON.
* services/: ApiService centralizado que gestiona peticiones con Dio y variables de entorno .env.
* isolates/: Lógica de procesamiento estadístico fuera del hilo principal.
* views/: Pantallas divididas por módulos (Accidentes, Establecimientos, Home).
* routes/: Navegación declarativa mediante go_router.
### 5. Navegación y Rutas con go_router
La navegación del proyecto se gestionó mediante una arquitectura declarativa, centralizando las rutas y el paso de datos en un solo lugar.

**Ruta Raíz (/)**

* Pantalla: HomeScreen.

* Propósito: Dashboard principal con acceso a los módulos de estadísticas y gestión.

* Parámetros: Ninguno.

**Ruta de Estadísticas (/accidentes)**

* Pantalla: AccidentesView.

* Propósito: Visualización de las 4 gráficas de accidentalidad de Tuluá.

* Parámetros: No recibe parámetros externos, ya que consume los datos directamente mediante el ApiService y los procesa con el Isolate.

**Ruta de Listado (/establecimientos)**

* Pantalla: EstablecimientosListView.

* Propósito: Visualización de los establecimientos creados en la API.

* Parámetros: Ninguno.

**Ruta de Creación (/establecimiento-form)**

* Pantalla: EstablecimientoFormView.

* Propósito: Abrir un formulario limpio para registrar un nuevo establecimiento.

* Parámetros: Ninguno (el constructor de la vista recibe un objeto nulo).

**Ruta de Edición (/establecimiento-edit)**

* Pantalla: EstablecimientoFormView.

* Propósito: Cargar los datos de un establecimiento existente para su modificación.

* Parámetros: Objeto extra. Se envía el modelo completo de tipo Establecimiento desde la lista. Esto permite que el formulario se pre-llene instantáneamente con el nombre, dirección e imagen actual sin hacer una nueva petición.
