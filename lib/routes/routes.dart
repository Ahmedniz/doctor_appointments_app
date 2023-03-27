import 'package:doctor_app/auth/phone.dart';
import 'package:doctor_app/screens/find_doctor.dart';
import 'package:doctor_app/screens/records/records.dart';
import 'package:doctor_app/screens/search_location.dart';
import 'package:flutter/material.dart';

import '../screens/navigation.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const BottomNavigator());
      case '/phoneAuthPage':
        return MaterialPageRoute(builder: (_) => const PhoneAuthPage());
      case '/findDoctor':
        return MaterialPageRoute(builder: (_) => const FindDoctor());
      case '/location':
        return MaterialPageRoute(builder: (_) => const LocationPage());
      case '/records':
        return MaterialPageRoute(builder: (_) => const Records());

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
