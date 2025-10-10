/*
 * @class CustomAppBar
 * @description Clase encargada de contener el AppBar personalizado de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Mostrar botón de volver a la pantalla anterior
  final bool showBack;
  // Callback para el botón de volver
  final VoidCallback? onBack;
  // Callbacks para los botones
  final VoidCallback? onProfileTap;
  // Callback para cambiar el idioma de la aplicación (Español-Inglés)
  final VoidCallback? onLanguageTap;
  // Callback para cambiar el tema de la aplicación (claro-oscuro)
  final VoidCallback? onThemeTap;

  const CustomAppBar({
    Key? key,
    this.onProfileTap,
    this.onLanguageTap,
    this.onThemeTap,
    this.showBack = false,
    this.onBack,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ), // Padding interno para separar los iconos de los bordes
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Botón de volver o icono de huella
            showBack
                ? _CircleIconButton(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  )
                : _CircleIconButton(
                    child: Icon(Icons.pets, color: Colors.white, size: 20),
                    onTap: onProfileTap,
                  ),
            // Configuración de la aplicación (tema e idioma)
            Row(
              children: [
                // Botón para el control de idioma (Español-Inglés)
                _CircleIconButton(
                  child: Text(
                    Localizations.localeOf(context).languageCode.toUpperCase(),
                    style: AppTheme.text12FFFFFFBold2,
                  ),
                  onTap: onLanguageTap,
                ),
                const SizedBox(width: 10),
                // Botón para el control del tema (claro/oscuro)
                _CircleIconButton(
                  child: Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Colors.white,
                    size: 20,
                  ),
                  onTap: onThemeTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Diseño y funcionalidad de cada opción del AppBar
class _CircleIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  static const Color lightCircleColor = Color(0xFFBFC5CE);
  static const Color darkCircleColor = Color(0xFF323344);

  const _CircleIconButton({Key? key, required this.child, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Control de tema oscuro/claro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Color del círculo según el tema
    final Color circleColor = isDark ? darkCircleColor : lightCircleColor;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
