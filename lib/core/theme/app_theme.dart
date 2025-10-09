/*
 * @class AppTheme
 * @description Clase encargada de contener la configuración de temas de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 08/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Lista de colores
  static const Color purpleColor6529CD = Color(0xFF6529CD);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color blackColor8A000000 = Color(0x8A000000);
  static const Color blackColorDD000000 = Color(0xDD000000);

  // Lista de estilos de texto
  static const TextStyle text11black87Semibold = TextStyle(
    fontSize: 11,
    color: Colors.black87,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle text11black87Bold = TextStyle(
    fontSize: 11,
    color: Colors.black87,
  );

  static const TextStyle text16black87Bold = TextStyle(
    fontSize: 16,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text14FFFFFFBold2 = TextStyle(
    fontSize: 14,
    color: whiteColor,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static const TextStyle text146529CDSemibold = TextStyle(
    fontSize: 14,
    color: purpleColor6529CD,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle text11FFFFFFSemibold = TextStyle(
    fontSize: 11,
    color: whiteColor,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle text20FFFFFFBold = TextStyle(
    fontSize: 20,
    color: whiteColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text16FFFFFFBold1 = TextStyle(
    fontSize: 16,
    color: whiteColor,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle text148A000000Medium = TextStyle(
    fontSize: 14,
    color: blackColor8A000000,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle text20DD000000Semibold = TextStyle(
    fontSize: 20,
    color: blackColorDD000000,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle text12FFFFFFBold2 = TextStyle(
    fontSize: 12,
    color: whiteColor,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );
}
