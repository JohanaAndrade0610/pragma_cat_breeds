/*
 * @class SupportContactWidget  
 * @description Clase encargada de contener el widget de contacto para la pantalla de Soporte.
 * @author Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class SupportContactWidget extends StatelessWidget {
  const SupportContactWidget({Key? key}) : super(key: key);

  /*
  * @method _launchWhatsApp
  * @description Método encargado de abrir WhatsApp para contacto.
  */
  void _launchWhatsApp() async {
    final url = Uri.parse('https://wa.me/${AppConfig.whatsappNumber}');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // WhatsApp card
        GestureDetector(
          onTap: _launchWhatsApp,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF6529cd).withOpacity(0.13),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF6529cd), width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo de WhatsApp
                  Image.asset(
                    'assets/images/whatsapp_logo.png',
                    width: 27,
                    height: 27,
                  ),
                  const SizedBox(width: 8),
                  // Etiqueta "Contactar por WhatsApp"
                  Flexible(
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      child: Text(
                        l10n.support_contact_by_whatsApp,
                        style: AppTheme.text146529CDSemibold.copyWith(
                          color: const Color(0xFF6529cd),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
