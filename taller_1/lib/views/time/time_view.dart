import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';

class TimeView extends StatefulWidget {
  const TimeView({super.key});

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  Timer? _timer;
  int _milisegundos = 0;
  bool _estaCorriendo = false;

  void _iniciarOPausar() {
    if (_estaCorriendo) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _milisegundos += 100;
        });
      });
    }
    setState(() => _estaCorriendo = !_estaCorriendo);
  }

  void _reiniciar() {
    _timer?.cancel();
    setState(() {
      _milisegundos = 0;
      _estaCorriendo = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Requisito 2: Limpieza de recursos al salir
    super.dispose();
  }

  String _formatearTiempo() {
    Duration duration = Duration(milliseconds: _milisegundos);
    String dosDigitos(int n) => n.toString().padLeft(2, "0");
    String minutos = dosDigitos(duration.inMinutes.remainder(60));
    String segundos = dosDigitos(duration.inSeconds.remainder(60));
    String milis = (duration.inMilliseconds.remainder(1000) ~/ 100).toString();
    return "$minutos:$segundos.$milis";
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "Cronómetro (Timer)",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatearTiempo(),
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _iniciarOPausar,
                  icon: Icon(_estaCorriendo ? Icons.pause : Icons.play_arrow),
                  label: Text(_estaCorriendo ? "Pausar" : "Iniciar/Reanudar"),
                ),
                const SizedBox(width: 20),
                OutlinedButton.icon(
                  onPressed: _reiniciar,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reiniciar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
