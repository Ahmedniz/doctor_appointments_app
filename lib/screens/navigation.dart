import 'package:doctor_app/screens/appointments/appointments.dart';
import 'package:doctor_app/screens/healthzone/healthzone.dart';
import 'package:doctor_app/screens/records/records.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/phone.dart';
import 'home.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _HomeState();
}

class _HomeState extends State<BottomNavigator> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 39, 39, 39),
        currentIndex: _currentPageIndex,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
          if (index == 1) {
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                Navigator.of(context).pushNamed('/phoneAuthPage');
              } else {
                _pageController.jumpToPage(index);
              }
            });
          } else {
            _pageController.jumpToPage(index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_folder_upload),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Healthzone',
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          const Home(),
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return const Appointments();
              } else {
                return const PhoneAuthPage();
              }
            },
          ),
          const Records(),
          const HealthZone(),
        ],
      ),
    );
  }
}
