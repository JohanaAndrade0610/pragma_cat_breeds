/*
 * @class buildInfoRow
 * @description Clase encargada de mostrar la información textual de los atributos de la raza
 * @author Angela Andrade
 * @version 1.0 09/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';

Widget buildInfoRow(String label, String? value, {bool isLast = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Título del atributo
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      const SizedBox(height: 6),
      // Texto perteneciente al atributo
      Text(
        value == null || value.isEmpty ? '-' : value,
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(152, 0, 0, 0),
        ),
        textAlign: TextAlign.justify,
      ),
      // Espaciado inferior si no es el último elemento
      if (!isLast) const SizedBox(height: 14),
    ],
  );
}
