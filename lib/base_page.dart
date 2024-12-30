import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget body;

  const BasePage({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false; // Retrieve this state as needed

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.center,
          children: [
            Text(title),
            Positioned(
              right: 10,
              child: IconButton(
                icon: Icon(isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
                onPressed: () {
                  // Toggle dark mode logic here
                },
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
    );
  }
}
