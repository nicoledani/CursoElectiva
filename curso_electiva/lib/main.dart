import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller Flutter 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Estado del título
  String tituloApp = "Hola, Flutter";

  void cambiarTitulo() {
    setState(() {
      tituloApp = (tituloApp == "Hola, Flutter")
          ? "¡Título cambiado!"
          : "Hola, Flutter";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Título actualizado"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloApp),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 10),

            // Nombre del estudiante
            const Text(
              "Nicolle Daniela Valverde Gallego",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            // Imágenes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  'https://images.dog.ceo/breeds/husky/n02110185_1469.jpg',
                  width: 100,
                  height: 100,
                ),
                Image.asset(
                  'assets/perro.jpg',
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Botón con icono
            ElevatedButton.icon(
              onPressed: cambiarTitulo,
              icon: const Icon(Icons.refresh),
              label: const Text("Cambiar título"),
            ),

            const SizedBox(height: 30),

            // Widget adicional 1: Container
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple, width: 1.5),
              ),
              child: const Text(
                "Container personalizado (Widget adicional)",
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Widget adicional 2: GridView
            const Text("Grid de elementos:"),

            const SizedBox(height: 10),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: const [
                  Card(child: Center(child: Text("Item 1"))),
                  Card(child: Center(child: Text("Item 2"))),
                  Card(child: Center(child: Text("Item 3"))),
                  Card(child: Center(child: Text("Item 4"))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}