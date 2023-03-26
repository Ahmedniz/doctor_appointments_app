import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get countriesItem {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
      value: "+92",
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/flags/pk.png',
              scale: 2,
            ),
          ),
          const Text('+92'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: "+91",
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/flags/in.png',
              scale: 2,
            ),
          ),
          const Text('+91'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: "+880",
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/flags/bd.png',
              scale: 2,
            ),
          ),
          const Text('+880'),
        ],
      ),
    ),
  ];
  return menuItems;
}
