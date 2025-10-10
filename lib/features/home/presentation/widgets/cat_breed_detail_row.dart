/*
 * @class buildInfoRow
 * @description Clase encargada de mostrar la información textual de los atributos de la raza
 * @author Angela Andrade
 * @version 1.0 09/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';

Widget buildInfoRow(
  String label,
  String? value, {
  bool isLast = false,
  BuildContext? context,
}) {
  // Obtener el contexto si no se proporciona
  final ctx =
      context ??
      (WidgetsBinding.instance.focusManager.primaryFocus?.context ??
          (throw Exception('No context available')));
  // Asignacion modo oscuro
  final isDark = Theme.of(ctx).brightness == Brightness.dark;
  // Colores de texto según el tema aplicado
  final Color mainTextColor = isDark ? Color(0xFFF3F3F7) : Colors.black;
  final Color secondaryTextColor = isDark ? Color(0xFFB0B0C3) : Colors.black87;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Título del atributo
      MediaQuery(
        data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: mainTextColor,
          ),
        ),
      ),
      const SizedBox(height: 6),
      // Texto perteneciente al atributo
      MediaQuery(
        data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
        child: Text(
          value == null || value.isEmpty ? '-' : value,
          style: TextStyle(fontSize: 12, color: secondaryTextColor),
          textAlign: TextAlign.justify,
        ),
      ),
      // Espaciado inferior si no es el último elemento
      if (!isLast) const SizedBox(height: 14),
    ],
  );
}