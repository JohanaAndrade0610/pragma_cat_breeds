/*
 * @class CustomFooter
 * @description Clase encargada de contener el footer de navegación en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 07/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';


import '../../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class CustomFooter extends StatelessWidget {
  // Índice del elemento seleccionado
  final int selectedIndex;
  // Función para manejar el toque en un elemento
  final Function(int) onItemTapped;

  const CustomFooter({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Detectar modo oscuro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Fondo del footer
    final Color backgroundColor = isDark ? const Color(0xFF23273A) : const Color(0xFFE0E3EA);
    // Circulo de cada opción
    final Color circleColor = isDark ? const Color(0xFF282C34) : const Color(0xFFBFC5CE);
    // Color del item seleccionado (morado)
    const Color selectedColor = AppTheme.purpleColor6529CD;
    // Color del icono (blanco)
    const Color iconColor = Colors.white;
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    // Items de navegación
    final items = [
      // Item Inicio
      _FooterNavItemData(
        iconFilled: Icons.home_rounded,
        iconOutline: Icons.home_outlined,
        label: l10n.footer_home,
      ),
      // Item Favoritos
      _FooterNavItemData(
        iconFilled: Icons.favorite_rounded,
        iconOutline: Icons.favorite_outline_rounded,
        label: l10n.footer_favorites,
      ),
      // Item Soporte
      _FooterNavItemData(
        iconFilled: Icons.support_agent_rounded,
        iconOutline: Icons.support_agent_outlined,
        label: l10n.footer_support,
      ),
    ];

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 15), // Padding para separar el footer de la pantalla
      child: LayoutBuilder(
        builder: (context, constraints) {
          final footerHeight =
              MediaQuery.of(context).size.height * 0.08; // El footer ocupa el 8% de la altura de la pantalla
          final circleDiameter = footerHeight - 16; // margen superior/inferior
          return Container(
            height: footerHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(footerHeight), // Bordes redondeados del footer
              boxShadow: [
                BoxShadow(
                  // Sombra sutil para dar efecto de elevación
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: List.generate(items.length, (i) {
                final isSelected = selectedIndex == i;
                // El botón seleccionado se expande, mientras los demás son círculos
                return isSelected
                    ? Expanded(
                        child: AnimatedContainer(
                          // Contenedor animado para el botón seleccionado
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease,
                          height: circleDiameter,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(circleDiameter / 2),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  items[i].iconFilled,
                                  color: iconColor,
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                ConstrainedBox(
                                  // Texto del item seleccionado
                                  constraints: BoxConstraints(maxWidth: circleDiameter * 2.2),
                                  child: Text(
                                    items[i].label,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppTheme.text14FFFFFFBold2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: circleDiameter,
                        height: circleDiameter,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: circleColor,
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox.expand(
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                items[i].iconOutline,
                                color: iconColor,
                                size: 28,
                              ),
                              onPressed: () => onItemTapped(i),
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      );
              }),
            ),
          );
        },
      ),
    );
  }
}

// Clase privada para manejar los datos de cada item del footer
class _FooterNavItemData {
  final IconData iconFilled;
  final IconData iconOutline;
  final String label;
  const _FooterNavItemData({required this.iconFilled, required this.iconOutline, required this.label});
}
