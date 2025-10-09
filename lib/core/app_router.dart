/*
 * @class AppRouter
 * @description Clase encargada de contener todas las rutas de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 08/10/2025 Documentación y creación de la clase.
 */

import 'package:go_router/go_router.dart';

import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/splash_screen.dart';
import '../features/support/presentation/screens/support_screen.dart';

class AppRouter {
  AppRouter._();
  static final AppRouter instance = AppRouter._();

  final router = GoRouter(
    // Ruta inicial
    initialLocation: '/',
    routes: [
      // Splash
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      // Home
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      // Favoritos
      // GoRoute(
      //   path: '/favorites',
      //   builder: (context, state) => FavoritesScreen(),
      // ),
      // Soporte
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportScreen(),
      ),
    ],
  );
}
