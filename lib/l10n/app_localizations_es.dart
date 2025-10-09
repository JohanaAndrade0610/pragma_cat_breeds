// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get footer_home => 'Inicio';

  @override
  String get footer_favorites => 'Favoritos';

  @override
  String get footer_support => 'Soporte';

  @override
  String get home_tittle => 'Razas de gatos';

  @override
  String get home_input_filter => 'Filtrar por palabra clave';

  @override
  String get no_connection_title => 'Sin conexión a internet';

  @override
  String get no_connection_message => 'Por favor, compruebe su conexión a Internet';

  @override
  String get support_you_have_questions => '¿Tienes dudas o inquietudes sobre este proyecto?';

  @override
  String get support_contact_us => '¡Contáctanos y te responderemos con gusto!';

  @override
  String get support_contact_by_whatsApp => 'Contactar por WhatsApp';
}
