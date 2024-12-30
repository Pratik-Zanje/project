import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;

  final Color color;
  final IconData icon; // New parameter for the icon

  const CardWidget({
    Key? key,
    required this.title,

    required this.color,
    required this.icon, // New parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40, // Adjust size as needed
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),

        ],
      ),
    );
  }
}
