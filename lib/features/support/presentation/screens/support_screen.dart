/*
 * @class SupportScreen
 * @description Clase encargada de contener la pantalla de Soporte en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_footer.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/theme_mode_notifier.dart';
import '../../../../core/locale_notifier.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/custom_animation.dart';
import '../widgets/support_contact_widget.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen>
    with SingleTickerProviderStateMixin {
  // Controlador de animaciones
  late final AnimationController _controller;

  /*
    * @method initState
    * @description Método encargado de inicializar el estado de la pantalla Soporte.
    */
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  /*
    * @method dispose
    * @description Método encargado de liberar los recursos cuando la pantalla Soporte es destruida.
    */
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    // Determinar el índice según la ruta actual
    final location = GoRouter.of(context).location;
    int selectedIndex = 2;
    if (location == '/')
      selectedIndex = 0;
    else if (location == '/favorites')
      selectedIndex = 1;

    return Scaffold(
      // AppBar generica de la aplicación
      appBar: CustomAppBar(
        onThemeTap: () {
          // Cambiar el tema entre tono claro y oscuro
          themeModeNotifier.value = themeModeNotifier.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light;
        },
        onLanguageTap: () {
          // Cambiar el idioma entre español e inglés
          localeNotifier.value = localeNotifier.value.languageCode == 'en'
              ? const Locale('es')
              : const Locale('en');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Card informativo
            Builder(
              builder: (context) {
                // Colores de las pantallas según el tema seleccionado
                final isDark = Theme.of(context).brightness == Brightness.dark;
                final Color cardColor = isDark
                    ? const Color(0xFF23273A)
                    : Colors.white;
                final Color borderColor = const Color(0xFF6529cd);
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: borderColor, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x331543CC),
                        blurRadius: 18,
                        spreadRadius: 2,
                        offset: Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 15,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icono de email
                      Icon(
                        Icons.email_outlined,
                        color: Color(0xFF6529cd),
                        size: 34,
                      ),
                      const SizedBox(height: 12),
                      MediaQuery(
                        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                        child: Text(
                          l10n.support_you_have_questions,
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.grey[800],
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Etiqueta "¡Contáctanos y te responderemos con gusto!"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                              child: Text(
                                l10n.support_contact_us,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white70
                                      : Colors.grey[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Botón de contacto por whatsapp
                      const SupportContactWidget(),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            // Animación de la ventana
            Flexible(
              child: CustomAnimation(
                assetPath: 'assets/lottie/support_animation.json',
                width: MediaQuery.of(context).size.width * 1,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/favorites');
              break;
            case 2:
              context.go('/support');
              break;
          }
        },
      ),
    );
  }
}
