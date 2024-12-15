import 'package:flutter/material.dart';

class AppTheme {
  static TextDirection textDirection = TextDirection.ltr;

  static ThemeData appTheme = _lightTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff0022C0),
      brightness: Brightness.light,
      primary: const Color(0xff0022C0),
      secondary: const Color(0xffce5d00),
      onSurface: Colors.black87,
      surface: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(color: Color(0xff0022C0), width: 2),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff0022C0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        textStyle: const TextStyle(
          fontFamily: 'AfacadFlux',
          fontSize: 21,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(color: Color(0xff0022C0), width: 2),
        // backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: const Color(0xff0022C0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        textStyle: const TextStyle(
          fontFamily: 'AfacadFlux',
          fontSize: 21,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
  );

  static ThemeData appThemeDark = _darkTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff0022C0),
      brightness: Brightness.dark,
      primary: const Color(0xffce5d00),
      onPrimary: Colors.white70,
      secondary: const Color(0xffce5d00),
      onSecondary: Colors.white70,
      surface: Colors.black87,
      onSurface: Colors.white70,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(color: Colors.white, width: 2),
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        textStyle: const TextStyle(
          fontFamily: 'AfacadFlux',
          fontSize: 21,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(color: Colors.white70, width: 2),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        textStyle: const TextStyle(
          fontFamily: 'AfacadFlux',
          fontSize: 21,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
  );

  AppTheme._();

  static final ThemeData _lightTheme = ThemeData(
    /// Brightness
    brightness: Brightness.light,

    /// Primary Color
    primaryColor: const Color(0xff3C4EC5),
    scaffoldBackgroundColor: const Color(0xffffffff),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffffffff),
      iconTheme: IconThemeData(color: Color(0xff495057)),
      actionsIconTheme: IconThemeData(color: Color(0xff495057)),
    ),

    // Drawer Theme
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xffffffff)),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xffffffff), elevation: 0),
    cardColor: const Color(0xfff0f0f0),

    fontFamily: 'AfacadFlux',
    textTheme: _getTextTheme(),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xff3C4EC5),
      splashColor: const Color(0xffeeeeee).withAlpha(100),
      highlightElevation: 8,
      elevation: 4,
      focusColor: const Color(0xff3C4EC5),
      hoverColor: const Color(0xff3C4EC5),
      foregroundColor: const Color(0xffeeeeee),
    ),

    // InputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xff3C4EC5), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 19,
        letterSpacing: 0.15,
      ),
      errorStyle: const TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 16, // Changed to 14
        letterSpacing: 0.15,
      ),
      suffixIconColor: const Color(0xff3C4EC5),
    ),

    /// Divider Theme
    dividerTheme:
        const DividerThemeData(color: Color(0xffe8e8e8), thickness: 1),
    dividerColor: const Color(0xffe8e8e8),

    /// Bottom AppBar Theme
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color(0xffeeeeee), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xff3d63ff),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff3d63ff), width: 2.0),
      ),
    ),

    /// CheckBox theme
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(const Color(0xffeeeeee)),
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xff3C4EC5);
          } else {
            return Colors.transparent;
          }
        },
      ),
    ),

    /// Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(const Color(0xff3C4EC5)),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0x990A6FB8);
        }
        return null;
      }),
      thumbColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xff3C4EC5);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xff3d63ff),
      inactiveTrackColor: const Color(0xff3d63ff).withAlpha(140),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: const Color(0xff3d63ff),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xffeeeeee),
      ),
    ),

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),
    indicatorColor: const Color(0xffeeeeee),
    highlightColor: const Color(0xffeeeeee),
    colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff3C4EC5), brightness: Brightness.light)
        .copyWith(surface: const Color(0xffffffff))
        .copyWith(error: const Color(0xfff0323c)),
  );

  static final ThemeData _darkTheme = ThemeData(
    /// Brightness
    brightness: Brightness.dark,

    /// Primary Color
    primaryColor: const Color(0xff069DEF),

    /// Scaffold and Background color
    scaffoldBackgroundColor: const Color(0xff161616),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff161616)),

    // Drawer Theme
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff161616)),

    fontFamily: 'AfacadFlux',
    textTheme: _getTextTheme(),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xff222327), elevation: 0),
    cardColor: const Color(0xff222327),

    /// Input (Text-Field) Theme
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white60),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white70, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white60),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 19,
        letterSpacing: 0.15,
      ),
      errorStyle: const TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 16, // Changed to 14
        letterSpacing: 0.15,
      ),
      suffixIconColor: Colors.white70,
    ),

    /// Divider Color
    dividerTheme:
        const DividerThemeData(color: Color(0xff363636), thickness: 1),
    dividerColor: const Color(0xff363636),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xff069DEF),
        splashColor: Colors.white.withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: const Color(0xff069DEF),
        hoverColor: const Color(0xff069DEF),
        foregroundColor: Colors.white),

    /// Bottom AppBar Theme
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color(0xff464c52), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xff069DEF),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff069DEF), width: 2.0),
      ),
    ),

    // CheckBox Theme
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(const Color(0xff464c52)),
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xff3C4EC5);
          } else {
            return Colors.transparent;
          }
        },
      ),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0x880A6FB8);
        }
        return null;
      }),
      thumbColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xff3C4EC5);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xff069DEF),
      inactiveTrackColor: const Color(0xff069DEF).withAlpha(100),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: const Color(0xff069DEF),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ),

    ///Other Color
    indicatorColor: Colors.white,
    disabledColor: const Color(0xffa3a3a3),
    highlightColor: Colors.white.withAlpha(28),
    splashColor: Colors.white.withAlpha(56),
    colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff069DEF), brightness: Brightness.dark)
        .copyWith(surface: const Color(0xff161616))
        .copyWith(error: Colors.orange),
  );

  static TextTheme _getTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(fontFamily: 'AfacadFlux', fontSize: 99),
      displayMedium: TextStyle(fontFamily: 'AfacadFlux', fontSize: 62),
      displaySmall: TextStyle(fontFamily: 'AfacadFlux', fontSize: 49),
      headlineMedium: TextStyle(fontFamily: 'AfacadFlux', fontSize: 35),
      headlineSmall: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 27,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
      labelLarge: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: .4,
      ),
      labelSmall: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 16.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: 'AfacadFlux',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    );
  }
}
