import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
  ),
  scaffoldBackgroundColor:
      const Color(0xFFF5F7FA),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
  ),
  elevatedButtonTheme:
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      minimumSize:
          const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15),
      ),
      elevation: 5,
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(15),
    ),
  ),
  inputDecorationTheme:
      InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(15),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
    ),
  ),
),
      home: const LoginScreen(),
    );
  }
}
