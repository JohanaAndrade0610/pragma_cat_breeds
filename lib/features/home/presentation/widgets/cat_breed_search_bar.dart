/*
 * @class CatBreedSearchBar
 * @description Clase encargada de mostrar la barra de búsqueda para filtrar razas de gatos.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';

class CatBreedSearchBar extends StatefulWidget {
  // Valor inicial del campo de búsqueda
  final String initialValue;
  // Callback para notificar cambios en el texto
  final ValueChanged<String> onChanged;
  // Texto de sugerencia cuando el campo está vacío
  final String hintText;
  // Color de fondo del campo de búsqueda
  final Color fillColor;

  const CatBreedSearchBar({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.hintText,
    required this.fillColor,
  }) : super(key: key);

  @override
  State<CatBreedSearchBar> createState() => _CatBreedSearchBarState();
}

class _CatBreedSearchBarState extends State<CatBreedSearchBar> {
  // Controlador de texto para manejar el estado del campo de búsqueda
  late final TextEditingController _controller;

  /*
  * @method initState
  * @description Método que se llama cuando se inicializa el estado del widget.
  */
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(_onTextChanged);
  }

  /*
  * @method didUpdateWidget
  * @description Método que se llama cuando el widget se actualiza.
  */
  @override
  void didUpdateWidget(covariant CatBreedSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  /*
  * @method _onTextChanged
  * @description Método que se llama cuando el texto del campo de búsqueda cambia.
  */
  void _onTextChanged() {
    widget.onChanged(_controller.text);
  }

  /*
  * @method dispose
  * @description Método que se llama cuando el widget se elimina de la jerarquía.
  */
  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Construcción del campo de búsqueda
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.text,
        maxLength: 50,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: widget.hintText,
          counterText: '',
          prefixIcon: SizedBox(
            width: 22,
            height: 22,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 5),
              // Imagen del gato ubicado a la izquierda del campo de búsqueda
              child: Image.asset(
                'assets/images/cat_logo.png',
                fit: BoxFit.contain,
                color: Color(0xFF6529CD),
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
          ),
          // Icono de búsqueda ubicado a la derecha del campo de búsqueda
          suffixIcon: const Icon(Icons.search, color: Color(0xFF6529CD)),
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFF6529CD), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFF6529CD), width: 2),
          ),
        ),
      ),
    );
  }
}
