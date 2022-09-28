import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:udhari/screens/home_screen.dart';
import 'package:udhari/screens/link_create.dart';
import 'package:udhari/screens/link_view.dart';
import 'package:udhari/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final FirebaseAuth auth = FirebaseAuth.instance;

    return GetMaterialApp(
      title: 'choton',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: const MaterialColor(
          0xFF1E1E1E,
          <int, Color>{
            50: Color(0xFF1E1E1E),
            100: Color(0xFF1E1E1E),
            200: Color(0xFF1E1E1E),
            300: Color(0xFF1E1E1E),
            400: Color(0xFF1E1E1E),
            500: Color(0xFF1E1E1E),
            600: Color(0xFF1E1E1E),
            700: Color(0xFF1E1E1E),
            800: Color(0xFF1E1E1E),
            900: Color(0xFF1E1E1E),
          },
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF1E1E1E),
          textTheme: ButtonTextTheme.primary,
          height: 60,
          minWidth: 200.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0f172a),
        cardTheme: const CardTheme(
          color: Color(0xFF1e293b),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1e293b),
        ),
        primaryColor: Colors.lightBlue,
        textTheme: GoogleFonts.soraTextTheme(ThemeData.dark().textTheme),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          height: 60,
          minWidth: 200.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: auth.currentUser != null
          ? HomeScreen.routeName
          : LoginScreen.routeName,
      getPages: [
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: LinkCreate.routeName,
          page: () => const LinkCreate(),
        ),
        GetPage(
          name: LinkView.routeName,
          page: () => LinkView(),
        )
      ],
    );
  }
}
