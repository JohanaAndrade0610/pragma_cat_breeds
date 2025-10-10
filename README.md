# Cat Breeds

Bienvenido/a a Cat Breeds una aplicación móvil destinada a consultar, filtrar y guardar información sobre razas de gatos. La aplicación consume la API pública de TheCatAPI (https://api.thecatapi.com/v1/breeds) y ofrece una interfaz de usuario moderna con soporte para dos idiomas, modo claro/oscuro, persistencia local y manejo básico de conectividad.

## Características

- Soporte multiidioma (inglés y español).
- Control de modo claro y oscuro.
- Validación de conexión a internet + pantalla de "Sin conexión".
- Persistencia local de razas favoritas usando SQLite.
- Arquitectura limpia (capas `data`, `domain`, `presentation`).
- Gestión de estado con `Cubit`.
- Inyección de dependencias centralizada.
- Pantallas principales: Splash, Home (lista + búsqueda), Detalle de raza, Favoritos, Soporte.

## Estructura del proyecto

- `lib/main.dart` / `lib/app.dart` — Punto de entrada y configuración global.
- `lib/core/app_router.dart` — Rutas principales de la aplicación.
- `lib/core/locale_notifier.dart` — Control del idioma (español/inglés).
- `lib/core/theme_mode_notifier.dart` — Control del tema (claro/oscuro).
- `lib/di/injection.dart` — Inyección de dependencias.
- `lib/features/favorites/` — Código y estructura de la pantalla Favoritos.
- `lib/features/home/` — Código y estructura de la pantalla Inicio.
- `lib/features/support/` — Código y estructura de la pantalla Soporte.

Cada feature sigue la separación: `data/`, `domain/`, `presentation/`.

## Flujo de la aplicación

1. Al momento de inicializar la aplicación por defecto se muestra la pantalla `SplashScreen` dónde se realiza la petición a la API TheCatAPI.
2. Una vez se obtienen las razas de gatos, la aplicación navega automáticamente a la pantalla `HomeScreen`, donde se muestra información básica de cada raza en una tarjeta. El usuario puede filtrar los datos por texto (nombre, origen o peso de la raza) y también puede accionar el botón “Ver más información” para acceder a los detalles completos de la raza.
3. Al accionar el botón “Ver más información” el usuario será dirigido a la pantalla `CatBreedDetailScreen`, donde se presenta información más específica de la raza. Desde esta pantalla, también es posible acceder a la página de Wikipedia para consultar información adicional. Además, la vista incluye la opción de marcar o desmarcar una raza como favorita, cuyo estado persiste localmente utilizando SQLite.
4. En la pantalla `FavoritesScreen`, se listan todas las razas marcadas como favoritas. Cada tarjeta muestra la fotografía junto al nombre de la raza y ofrece la opción de desmarcarla como favorita.
5. Finalmente, la pantalla `SupportScreen` permite al usuario contactar con un asesor a través de WhatsApp para recibir soporte o realizar consultas adicionales.

## Requisitos y configuración

Requisitos mínimos:

- Flutter SDK (estable).
- Android SDK (para compilar APK) o Xcode (para iOS, si procede).

## Cómo ejecutar (Windows PowerShell)

1. Asegúrese de tener Flutter instalado y configurado en su PATH.
2. Desde la raíz del proyecto ejecute:

```powershell
flutter clean
flutter pub get
flutter gen-l10n
flutter run
```

## Notas de desarrollo

- Localización
  - Los archivos `l10n/app_en.arb` y `l10n/app_es.arb` contienen las cadenas utilizadas en las traducciones.
  - Para regenerar los bindings de localización ejecute `flutter gen-l10n`.

- Cambiar idioma y tema
  - El cambio de idioma se gestiona desde `locale_notifier.dart` y se aplica globalmente.
  - El tema (claro/oscuro) se controla con `theme_mode_notifier.dart` y se aplica globalmente.

- Dependencias y DI
  - Revise `lib/di/injection.dart` para ver cómo se registran repositorios y usecases.

## Ficheros relevantes

- `pubspec.yaml` — dependencias y assets (Lottie, imágenes, fonts, entre otros).
- `lib/l10n/` — archivos de localización.

## Contribuir

⭐ ¡Si le gusta este proyecto, no olvide darle una estrella! ⭐

