import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/dino_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF020B13),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const ArkEncyclopediaApp());
}

class ArkEncyclopediaApp extends StatelessWidget {
  const ArkEncyclopediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARK Енциклопедія Динозаврів',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF030C16),
        primaryColor: const Color(0xFF00E5FF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          onPrimary: Color(0xFF020B13),
          secondary: Color(0xFF0091EA),
          surface: Color(0xFF061A2B),
          background: Color(0xFF030C16),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF041320),
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Color(0xFFE0F7FA),
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
          ),
          iconTheme: IconThemeData(color: Color(0xFF00E5FF)),
        ),
        dividerColor: const Color(0xFF003859),
      ),
      home: const DinoListScreen(),
    );
  }
}
