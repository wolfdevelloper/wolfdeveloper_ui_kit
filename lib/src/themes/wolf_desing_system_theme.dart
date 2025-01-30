import 'package:flutter/material.dart';

class WolfDesignSystemTheme {

  static BoxShadow get cardShadow => const BoxShadow(
      color: Color(0x26000000), // Sombra com opacidade
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0
  );

  static const EdgeInsets cardMargin = EdgeInsets.all(16);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFACBBB4),
      colorScheme: const ColorScheme.light(
          primary: Color(0xFFACBBB4),
          secondary: Color(0xFFD0BFB5),
          onPrimaryContainer: Colors.white //
          ),

      // Define o tema para os botões
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFACBBB4),
        ),
      ),

      // Define o tema para os ícones
      iconTheme: const IconThemeData(
        color: Color(0xFFACBBB4),
      ),

      // tipografia, espaçamento,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.black
        ),

      ),

      cardTheme: CardTheme(
        elevation: 4,
        margin: cardMargin,
        color: Colors.white,
        shadowColor: cardShadow.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Cantos arredondados, opcional
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFACBBB4),
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFFACBBB4),
        secondary: const Color(0xFFD0BFB5),
        onPrimaryContainer: Colors.grey[900],
      ),
    );
  }
}
