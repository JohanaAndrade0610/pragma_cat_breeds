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
    final Color backgroundColor = isDark
        ? const Color(0xFF23273A)
        : Colors.white;
    // Color del item seleccionado
    const Color selectedColor = AppTheme.purpleColor6529CD;
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

    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: double.infinity,
      // Diseño del contenedor del footer
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(items.length, (i) {
          final isSelected = selectedIndex == i;
          const Color customUnselectedColor = Color(0xFFBFC5CE);
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => onItemTapped(i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 6,
                  ), // Espacio superior antes de los iconos
                  // Icono del item
                  Icon(
                    isSelected ? items[i].iconFilled : items[i].iconOutline,
                    color: isSelected ? selectedColor : customUnselectedColor,
                    size: 28,
                  ),
                  // Nombre del item
                  Text(
                    items[i].label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected ? selectedColor : customUnselectedColor,
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  // Línea indicadora del item seleccionado
                  if (isSelected) ...[
                    const SizedBox(height: 6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 4,
                      width: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Espacio después de la línea
                    const SizedBox(height: 10),
                  ] else ...[
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Clase privada para manejar los datos de cada item del footer
class _FooterNavItemData {
  final IconData iconFilled; // Icono cuando está seleccionado
  final IconData iconOutline; // Icono cuando no está seleccionado
  final String label; // Etiqueta del item
  const _FooterNavItemData({
    required this.iconFilled,
    required this.iconOutline,
    required this.label,
  });
}
