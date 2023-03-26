import 'package:flutter/material.dart';

class HealthZone extends StatefulWidget {
  const HealthZone({super.key});

  @override
  State<HealthZone> createState() => _HealthZoneState();
}

class _HealthZoneState extends State<HealthZone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Zone'),
      ),
    );
  }
}
