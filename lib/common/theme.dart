import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);
  static ColorScheme darkScheme() {
    return const ColorScheme(
      background: Colors.black,
      onBackground: Color(0xffffffff),
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xff2ae500),
      onPrimary: Color(0xff053900),
      primaryContainer: Color(0xff2df500),
      onPrimaryContainer: Color(0xff084a00),
      secondary: Color(0xff72de58),
      onSecondary: Color(0xff053900),
      secondaryContainer: Color(0xff137e00),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff003823),
      tertiaryContainer: Color(0xff00f2a3),
      onTertiaryContainer: Color(0xff00492e),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0c1609),
      onSurface: Color(0xffdae6d0),
      onSurfaceVariant: Color(0xffbaccb0),
      outline: Color(0xff85967c),
      outlineVariant: Color(0xff3c4b35),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdae6d0),
      inversePrimary: Color(0xff106e00),
    
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      background: Colors.black,
      onBackground: Color(0xffffffff),
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xff2ae500),
      onPrimary: Color(0xff053900),
      primaryContainer: Color(0xff2df500),
      onPrimaryContainer: Color(0xff022600),
      secondary: Color(0xff76e35c),
      onSecondary: Color(0xff011b00),
      secondaryContainer: Color(0xff3aa625),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff003823),
      tertiaryContainer: Color(0xff00f2a3),
      onTertiaryContainer: Color(0xff002515),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0c1609),
      onSurface: Color(0xfff2ffe8),
      onSurfaceVariant: Color(0xffbed0b4),
      outline: Color(0xff97a88d),
      outlineVariant: Color(0xff77886f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdae6d0),
      inversePrimary: Color(0xff0a5400),
     
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
       background: Colors.black,
      onBackground: Color(0xffffffff),
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 28, 23, 23),
      surfaceTint: Color(0xff2ae500),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff2df500),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff2ffe7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff76e35c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff00f2a3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0c1609),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff2ffe7),
      outline: Color(0xffbed0b4),
      outlineVariant: Color(0xffbed0b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdae6d0),
      inversePrimary: Color(0xff043200),
    
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
