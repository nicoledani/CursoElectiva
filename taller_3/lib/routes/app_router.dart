import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/universidad_form_view.dart';
import '../views/universidad_list_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/universidades',
  routes: [
    GoRoute(
      path: '/universidades',
      builder: (context, state) => const UniversidadListView(),
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) => const UniversidadFormView(),
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (context, state) =>
              UniversidadFormView(id: state.pathParameters['id']),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruta no encontrada')),
      body: Center(child: Text(state.error.toString())),
    );
  },
);
