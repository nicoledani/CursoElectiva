import 'package:go_router/go_router.dart';
import '../views/home/home_screen.dart';
import '../views/accidentes/accidentes_view.dart';
import '../views/establecimientos/establecimientos_list_view.dart';
import '../views/establecimientos/establecimiento_form_view.dart';
import '../models/establecimiento_model.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/accidentes',
      builder: (context, state) => const AccidentesView(),
    ),
    GoRoute(
      path: '/establecimientos',
      builder: (context, state) => const EstablecimientosListView(),
    ),
    GoRoute(
      path: '/formulario',
      builder: (context, state) {
        // Recibimos el objeto para editar, si es nulo es para crear
        final est = state.extra as Establecimiento?;
        return EstablecimientoFormView(establecimiento: est);
      },
    ),
  ],
);