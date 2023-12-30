import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CustomLightThemeColor{
  static Color backgroundColor = const Color.fromRGBO(226, 236, 240, 1);
  static Color shadowDarkColor = Colors.black;
  static Color shadowLightColor = Colors.white;
  static Color primaryTextColor = Colors.black;
  static Color secondaryTextColor = Colors.black54;
  static Color primaryVividColor = Colors.blue;
  static Color secondaryVividColor = Colors.teal;
}


class CustomDarkThemeColor{
  static Color backgroundColor = const Color(0xFF262626);
  static Color shadowDarkColor = Colors.black.withOpacity(0.8);
  static Color shadowLightColor = const Color(0xFF2D2D2D);
  static Color primaryTextColor = Colors.white;
  static Color secondaryTextColor = Colors.white70;
  static Color primaryVividColor = Colors.blue;
  static Color secondaryVividColor = Colors.teal;
}

class CustomGradient{
  static LinearGradient primaryGradient = LinearGradient(colors: [
    Colors.blue.shade400,
    Colors.blue.shade900,
  ]);

  static LinearGradient primaryGradient2 = LinearGradient(colors: [
    Colors.blue.shade900,
    Colors.blue.shade400,
  ]);

  static LinearGradient secondaryGradient = LinearGradient(colors: [
    Colors.teal.shade300,
    Colors.teal.shade500,
  ]);
}

class CustomNeumorphicStyle{
  static NeumorphicStyle primayNeumorphicStyle = const NeumorphicStyle(
    intensity: 1,
    depth: 10,
  );
}

