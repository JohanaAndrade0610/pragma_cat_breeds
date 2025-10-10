/*
 * @class buildStarsRow
 * @description Clase encargada de mostrar una fila de estrellas para calificaciones de atributos de la raza.
 * @author Angela Andrade
 * @version 1.0 09/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';

Widget buildStarsRow(String label, int? value, {bool isLast = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Título del atributo
      MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
      const SizedBox(height: 6),
      // Fila de estrellas según la calificación (0-5)
      Row(
        children: List.generate(5, (index) {
          int rating = value ?? 0;
          return Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Color(0xFF6529CD),
            size: 16,
          );
        }),
      ),
      // Espaciado inferior si no es el último elemento
      if (!isLast) const SizedBox(height: 14),
    ],
  );
}
