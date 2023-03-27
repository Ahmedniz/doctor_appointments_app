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
      bottomNavigationBar: NavigationBar(
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        height: 60,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            if (FirebaseAuth.instance.currentUser == null && index == 1 || index == 2) {
              _currentPageIndex = 0; // Set to Home if user is not authenticated and index is Appointments
            } else {
              _currentPageIndex = index;
            }
          });
          if (index == 1) {
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                Navigator.of(context).pushNamed('/phoneAuthPage');
              } else {
                _pageController.jumpToPage(index);
              }
            });
          } else if (index == 2) {
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                Navigator.of(context).pushNamed('/records');
              } else {
                _pageController.jumpToPage(index);
              }
            });
          } else {
            _pageController.jumpToPage(index);
          }
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.date_range),
            icon: Icon(Icons.date_range_outlined),
            label: 'Appointments',
          ),
          NavigationDestination(
            icon: Icon(Icons.drive_folder_upload),
            label: 'Records',
          ),
          NavigationDestination(
            icon: Icon(Icons.health_and_safety),
            label: 'Healthzone',
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            if (FirebaseAuth.instance.currentUser == null && index == 1) {
              _currentPageIndex = 0; // Set to Home if user is not authenticated and index is Appointments
            } else {
              _currentPageIndex = index;
            }
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
                _currentPageIndex = 0;
                return const PhoneAuthPage();
              }
            },
          ),
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return const Records();
              } else {
                _currentPageIndex = 0;
                return const PhoneAuthPage();
              }
            },
          ),
          const HealthZone(),
        ],
      ),
    );
  }
}
