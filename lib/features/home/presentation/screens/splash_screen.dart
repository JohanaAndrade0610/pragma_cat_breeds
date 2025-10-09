/*
 * @class SplashScreen
 * @description Clase encargada de contener el splash de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 08/10/2025 Documentación y creación de la clase.
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/home_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Variable para controlar si los datos de los gatos han sido cargados
  bool _dataLoaded = false;
  // Variable para controlar si se debe navegar a la pantalla de inicio
  bool _navigated = false;

 /*
  * @method initState
  * @description Método encargado de inicializar el splash.
  */
  @override
  void initState() {
    super.initState();
    // Inicia la carga de razas de gatos apenas se construye el widget
    Future.microtask(() => context.read<HomeCubit>().loadCatBreeds());
  }

 /*
  * @method dispose
  * @description Método encargado de liberar los recursos utilizados por el splash.
  */
  @override
  void dispose() {
    super.dispose();
  }

  /*
   * @method _tryNavigate
   * @description Método encargado de navegar a la pantalla de inicio si los datos han sido cargados.
   */
  void _tryNavigate() {
    if (_dataLoaded && !_navigated) {
      _navigated = true;
      Future.delayed(const Duration(milliseconds: 3000), () {
        if (mounted) {
          GoRouter.of(context).go('/home');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Color de la ventana
      backgroundColor: Colors.white,
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeLoaded) {
            _dataLoaded = true;
            _tryNavigate();
          } else if (state is HomeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Espacio superior
            SizedBox(height: MediaQuery.of(context).padding.top),
            // Contenido central
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo de la ventana
                    Image.asset(
                      'assets/images/cat_breeds_logo.png',
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            // Texto y logo ubicados en la parte inferior
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'For pragma',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    'assets/images/pragma_logo.png',
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
