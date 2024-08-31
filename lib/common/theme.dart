import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);
  static ColorScheme darkScheme() {
    return const ColorScheme(
      background: Colors.black,
      onBackground: Color(4294967295),
      brightness: Brightness.dark,
      primary: Color(4294967295),
      surfaceTint: Color(4281001216),
      onPrimary: Color(4278532352),
      primaryContainer: Color(4281201920),
      onPrimaryContainer: Color(4278733312),
      secondary: Color(4285718104),
      onSecondary: Color(4278532352),
      secondaryContainer: Color(4279467520),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4294967295),
      onTertiary: Color(4278204451),
      tertiaryContainer: Color(4278252195),
      onTertiaryContainer: Color(4278208814),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4278982153),
      onSurface: Color(4292536016),
      onSurfaceVariant: Color(4290432176),
      outline: Color(4286944892),
      outlineVariant: Color(4282141493),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292536016),
      inversePrimary: Color(4279266816),
    
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      background: Colors.black,
      onBackground: Color(4294967295),
      brightness: Brightness.dark,
      primary: Color(4294967295),
      surfaceTint: Color(4281001216),
      onPrimary: Color(4278532352),
      primaryContainer: Color(4281201920),
      onPrimaryContainer: Color(4278330880),
      secondary: Color(4285981532),
      onSecondary: Color(4278262528),
      secondaryContainer: Color(4282033701),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4278204451),
      tertiaryContainer: Color(4278252195),
      onTertiaryContainer: Color(4278199573),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4278982153),
      onSurface: Color(4294115304),
      onSurfaceVariant: Color(4290695348),
      outline: Color(4288129165),
      outlineVariant: Color(4286023791),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292536016),
      inversePrimary: Color(4278866944),
     
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
       background: Colors.black,
      onBackground: Color(4294967295),
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 28, 23, 23),
      surfaceTint: Color(4281001216),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4281201920),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294115303),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4285981532),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4278252195),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4278982153),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294115303),
      outline: Color(4290695348),
      outlineVariant: Color(4290695348),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292536016),
      inversePrimary: Color(4278465024),
    
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
