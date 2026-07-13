import 'package:flutter/material.dart';

/// Reusable widget for displaying one weather detail.
class WeatherInfo extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const WeatherInfo({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 50),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(color: Colors.white70)),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}