Configuration Layer
===================

Overview
--------

The Configuration layer manages application-wide settings, themes, routes, and translations for the MS-dTMT application. This layer centralizes configuration management, making it easier to adjust application behavior across different environments and providing consistent styling throughout the app.

Key Components
--------------

Theme Configuration
^^^^^^^^^^^^^^^^^^^

**AppColors**

The AppColors class defines the application's color scheme, including:

- Primary colors (``_primaryBlue``, ``_primaryBlueDark``) for buttons and highlights
- Secondary colors (``secondaryBlue``, ``secondaryBlueDark``) for subtle accents
- Text colors (``mainBlackText``, ``darkText``, ``blueText``) for proper contrast
- Special colors for TMT test components (``testTMTBoardBackground``, ``testTMTCorrectCircleStroke``)
- Dialog colors and button colors with dark mode variants

The class provides helper methods like ``getPrimaryBlueDependIsDarkMode()`` to retrieve theme-appropriate colors based on the current mode, ensuring visual consistency across the application.

**AppTextStyle**

The AppTextStyle class defines specific text styles for application components:

- App bar titles with ``appBarTitle``
- TMT game text with ``tmtGameCircleText`` and ``tmtGameCircleBeginAndLastText``
- Custom dialog components with ``customDialogTitle`` and ``customDialogContent``
- Button text styles with ``customPrimaryButtonText`` and ``customDialogButton``
- TMT result components with ``tmtResultCardText`` and ``tmtResultThanksText``
- Various screen-specific styles for forms and headers

**TextStyleBase**

TextStyleBase provides the foundation for all typography in the application, defining:

- Base text sizes for different categories (heading, body, action, caption)
- Scale factors for tablet vs. phone displays
- Font weight variations
- Standardized styles for hierarchy (h1-h5, bodyXL-bodyXS, actionL-actionS)

This class ensures typography consistency and adapts text sizes based on device type.

**AppFontWeight**

AppFontWeight defines standardized font weight constants used throughout the application:

- ``thin`` (w100)
- ``extraLight`` (w200)
- ``light`` (w300)
- ``normal`` (w400)
- ``medium`` (w500)
- ``semiBold`` (w600)
- ``bold`` (w700)
- ``extraBold`` (w800)
- ``black`` (w900)

This ensures typography consistency and follows design system principles.

**ThemeController**

ThemeController manages the application's theme state, providing:

- Theme persistence between app sessions using SharedPreferences
- Methods to toggle between light, dark, and system themes
- Observable state with Rx properties
- Helper properties like ``isDarkMode`` for responsive UI

**AppTheme**

AppTheme defines complete ThemeData configurations for both light and dark modes:

- Base application theme
- Light theme with appropriate surfaces, text colors, and component styles
- Dark theme with adjusted colors and contrast levels
- Consistent component theming across both modes

**InputDecoration**

The CustomInputDecoration class provides consistent styling for form input fields:

- Border radius and styling
- Focus states with primary color highlighting
- Error state visualization
- Text styles for input, hint, and read-only states

Routing Configuration
^^^^^^^^^^^^^^^^^^^^^

**AppRoutes**

The Routes class defines constants for all application routes:

- Screen paths like home, tmt_test, register_user
- Organized naming conventions
- Route name constants for consistent navigation

**AppPages**

AppPages defines the application's navigation structure:

- Initial route configuration
- Page-to-route mapping with GetPage implementation
- Binding registration for each route
- Screen widget association

This configuration enables dependency injection during navigation and maintains a modular structure.

**AppRouteObserver**

AppRouteObserver monitors navigation events throughout the application:

- Tracks current route with Rx properties
- Observes route changes (push, pop, etc.)
- Updates current route name for reactive UI updates
- Enables components to react to navigation changes

Translation Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^

**AppTranslations**

AppTranslations manages internationalization for the application:

- Support for multiple languages (English, Spanish, Chinese)
- Device locale detection
- Fallback locale handling
- Translation key management

**Message Classes**

The configuration includes structured message classes for different features:

- TMT game text translations
- Form labels and error messages
- Button texts and dialog content
- Screen titles and instructions

These classes organize translations by feature area, making maintenance easier.

Benefits of the Configuration Layer
-----------------------------------

1. **Consistency**: Ensures visual and behavioral consistency throughout the application
2. **Maintainability**: Centralizes configuration, making updates simpler and more reliable
3. **Adaptability**: Facilitates theme switching and responsive design
4. **Internationalization**: Supports multiple languages with organized translation structure
5. **Organization**: Separates configuration concerns from business logic

The Configuration layer plays a critical role in maintaining a well-structured application by isolating settings and styles from implementation details, following the separation of concerns principle.