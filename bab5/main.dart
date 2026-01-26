import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/edit_note_page.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatatanKu Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
        // cardTheme intentionally left out for broader SDK compatibility;
        // individual Cards will use shape/elevation directly.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(elevation: 4, backgroundColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const LoginPage(),
        '/home': (ctx) => const HomePage(),
        '/edit': (ctx) => const EditNotePage(),
      },
      onGenerateRoute: (settings) {
        // optional central route handling (kept simple)
        if (settings.name == '/debug') {
          return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Debug route'))));
        }
        return null; // fallback to routes table
      },
    );
  }
}
