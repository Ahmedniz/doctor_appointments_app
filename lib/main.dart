import 'package:doctor_app/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'screens/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const myColor = Color.fromARGB(255, 255, 190, 85);
    final myMaterialColor = MaterialColor(myColor.value, {
      50: myColor.withOpacity(0.1),
      100: myColor.withOpacity(0.2),
      200: myColor.withOpacity(0.3),
      300: myColor.withOpacity(0.4),
      400: myColor.withOpacity(0.5),
      500: myColor.withOpacity(0.6),
      600: myColor.withOpacity(0.7),
      700: myColor.withOpacity(0.8),
      800: myColor.withOpacity(0.9),
      900: myColor.withOpacity(1.0),
    });

    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: myMaterialColor,
        appBarTheme: const AppBarTheme(toolbarTextStyle: TextStyle(color: Colors.black)),
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          floatingLabelStyle: TextStyle(color: myColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: myColor,
            ),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
        ),
      ),
      home: const BottomNavigator(),
    );
  }
}
