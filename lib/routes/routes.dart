import 'package:doctor_app/auth/phone.dart';
import 'package:flutter/material.dart';

import '../screens/navigation.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const BottomNavigator());
      case '/phoneAuthPage':
        return MaterialPageRoute(builder: (_) => const PhoneAuthPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          centerTitle: true,
        ),
        body: const Center(child: Text('Page Not found')),
      );
    });
  }
}
