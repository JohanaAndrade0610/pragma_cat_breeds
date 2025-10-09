/*
 * @class CustomAnimation
 * @description Clase encargada de contener el widget de animación Lottie para cualquier pantalla.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomAnimation extends StatefulWidget {
  // Ruta de la animación
  final String assetPath;
  // Ancho de la animación
  final double width;
  // Repetir animación
  final bool repeat;
  // Controlador externo opcional
  final AnimationController? controller;
  // Callback cuando la animación se carga
  final void Function(LottieComposition)? onLoaded;

  const CustomAnimation({
    Key? key,
    required this.assetPath,
    required this.width,
    this.repeat = true,
    this.controller,
    this.onLoaded,
  }) : super(key: key);

  @override
  State<CustomAnimation> createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _internalController;
  AnimationController get _controller =>
      widget.controller ?? _internalController!;

  /*
  * @method initState
  * @description Método encargado de inicializar el estado de la animación Lottie.
  */
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = AnimationController(vsync: this);
    }
  }

  /*
  * @method dispose
  * @description Método encargado de liberar los recursos utilizados por la animación Lottie.
  */
  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Animación Lottie
    return LottieBuilder.asset(
      widget.assetPath,
      controller: _controller,
      width: widget.width,
      fit: BoxFit.contain,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        if (widget.repeat) {
          _controller.repeat();
        } else {
          _controller.forward();
        }
        if (widget.onLoaded != null) {
          widget.onLoaded!(composition);
        }
      },
    );
  }
}
