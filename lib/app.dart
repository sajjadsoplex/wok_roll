import 'package:flutter/material.dart';
import 'scenes/story_controller.dart';

class WokAndRollApp extends StatelessWidget {
  const WokAndRollApp({super.key});

  @override
  Widget build(BuildContext context) {
    const berry = Color(0xFFA52D63);
    return MaterialApp(
      title: 'Wok & Roll | Chowmein Corner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFCE4EF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE83E83),
          primary: const Color(0xFFE83E83),
          secondary: const Color(0xFFFFD76A),
          surface: const Color(0xFFFFF7F0),
        ),
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.w900, color: berry),
          headlineMedium: TextStyle(fontWeight: FontWeight.w900, color: berry),
          titleLarge: TextStyle(fontWeight: FontWeight.w800, color: berry),
          bodyLarge: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF563344)),
        ),
      ),
      home: const StoryController(),
    );
  }
}
