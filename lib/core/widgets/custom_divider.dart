/*
 * @class CustomDivider
 * @description Clase encargada de contener el widget para dividir diferentes secciones en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  // Grosor de la línea divisoria
  final double thickness;
  // Color del divisor
  final Color color;
  // Espacio inicial del divisor
  final double indent;
  // Espacio final del divisor
  final double endIndent;
  // Margen alrededor del divisor
  final EdgeInsetsGeometry? margin;

  const CustomDivider({
    Key? key,
    this.thickness = 1.2,
    this.color = const Color(0xFFBFC5CE),
    this.indent = 0,
    this.endIndent = 0,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Divider(
        thickness: thickness,
        color: color,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}
