// import 'package:brain_bridge_update/AuthScreen/LoginScreen.dart';
// import 'package:brain_bridge_update/splashscreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: SplashScreen(),
//     );
//   }
// }

import 'package:brain_bridge_update/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  String? theme = prefs.getString('app_theme');
  ThemeMode themeMode = ThemeMode.system;

  if (theme == 'light') themeMode = ThemeMode.light;
  if (theme == 'dark') themeMode = ThemeMode.dark;

  runApp(MyApp(themeMode));
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

class MyApp extends StatelessWidget {
  final ThemeMode initialTheme;

  const MyApp(this.initialTheme, {super.key});

  @override
  Widget build(BuildContext context) {
    themeNotifier.value = initialTheme;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Theme Switcher',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
          ),
          themeMode: currentTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
